require "httparty"
require_relative "../models/repo"

class RepoFetcher
  class RateLimitExceeded < StandardError; end
  class NotFound < StandardError; end

  attr_accessor :username, :response, :total_pages, :repos
  include HTTParty
  base_uri "https://api.github.com"

  def self.fetch_repos(username)
    fetcher = new(username)
    fetcher.fetch_repos
    fetcher.repos
  end

  def initialize(username)
    @username = username
    @response = nil
    @current_page = 1
    @total_pages = 1
    @repos = []
  end

  def fetch_repos
    while true do
      query = { query: { page: @current_page } }
      @response = self.class.get("/users/#{@username}/repos", query)
      if @response.code == 200
        parse_successful_response
      else
        parse_error_response
      end

      break if @current_page >= @total_pages
      @current_page += 1
    end
  end

  private

  def parse_successful_response
    parse_pagination_header
    parse_response
  end

  def parse_error_response
    headers = @response.headers
    message = @response.parsed_response['message']
    if @response.code == 403
      rate_limit_remaining = headers["x-ratelimit-remaining"].to_i
      rate_limit_resets_at = Time.at(headers["x-ratelimit-reset"].to_i).to_datetime.to_s
      raise RateLimitExceeded.new("Rate Limit Exceeded: Next reset at #{rate_limit_resets_at}") if rate_limit_remaining == 0
    elsif @response.code == 404
      raise NotFound.new("No Github user by the username of #{@username}")
    else
      raise Exception.new(message)
    end
  end

  def parse_pagination_header
    header = @response.headers["link"]
    return if header.nil?
    pagination_links = {}
    header.split(',').each do |link|
      section = link.split(';')
      url = section[0].match(/page=(\d*)/)[1].strip
      name = section[1].match(/rel="(.*)"/)[1].strip
      pagination_links[name] = url
    end
    @total_pages = (pagination_links["last"] || @total_pages).to_i
  end

  def parse_response
    body = @response.parsed_response
    repos = body.map{|repo_hash| Repo.new_from_hash(repo_hash) }
    @repos.concat(repos)
  end

end