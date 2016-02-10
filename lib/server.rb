$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.'))

require 'sinatra/base'
require 'sinatra/namespace'
require "sinatra/json"
require 'haml'
require 'tilt/haml'
require 'puma'

require 'models/user'
require 'models/repo'
require 'services/repo_fetcher'

class GitStars < Sinatra::Application
  register Sinatra::Namespace
  register Sinatra::JSON

  set :server, :puma
  set :public_folder, Proc.new { File.join(File.dirname(__FILE__), '..', 'public') }
  set :views, Proc.new { File.join(File.dirname(__FILE__), '.', 'templates') }

  namespace "/api" do
    get "/users/:username" do
      begin
        @user = User.with_username(params[:username])
        @user.repos = RepoFetcher.fetch_repos(@user.username)
        json @user
      rescue RepoFetcher::NotFound => e
        status 404
        json({ message: e })
      rescue RepoFetcher::RateLimitExceeded => e
        status 429
        json({ message: e })
      end
    end
  end

  get "/" do
    haml :index, format: :html5
  end
end