class User
  attr_accessor :username, :repos

  def self.with_username(username)
    new.tap do |obj|
      obj.username = username
      obj.repos = []
    end
  end

  def sorted_repos
    repos.sort_by(&:stargazers_count).reverse
  end

  def total_stars
    repos.map(&:stargazers_count).inject(0, :+)
  end

  def total_repos
    repos.size
  end

  def average_stars
    return 0 if repos.empty?
    total_stars / total_repos
  end

  def to_json(options = {})
    {
      username: username,
      repos: sorted_repos,
      total_stars: total_stars,
      average_stars: average_stars,
      total_repos: total_repos
    }.to_json
  end
end