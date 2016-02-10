FactoryGirl.define do
  factory :repo do
    name "Test Repo"
    full_name "test/test-repo"
    description "This is a description."
    url "https://github.com/repos/test-repo"
    stargazers_count {rand(0..250)}
    language 'ruby'
  end
end