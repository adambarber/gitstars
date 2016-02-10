class Repo < Object
  attr_accessor :name, :full_name, :description, :url, :stargazers_count, :language

  def self.new_from_hash(attributes)
    new.tap do |obj|
      obj.name = attributes.fetch('name', nil)
      obj.full_name = attributes.fetch('full_name', nil)
      obj.description = attributes.fetch('description', nil)
      obj.url = attributes.fetch('html_url', nil)
      obj.stargazers_count = attributes.fetch('stargazers_count', nil)
      obj.language = attributes.fetch('language', nil)
    end
  end

  def to_json(options = {})
    {
      name: name,
      full_name: full_name,
      description: description,
      html_url: url,
      stargazers_count: stargazers_count,
      language: language
    }.to_json
  end
end