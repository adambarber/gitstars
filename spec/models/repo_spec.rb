require "models/repo"
require "factories/repo"

describe Repo do
  let(:attributes_hash) { {'name' => 'test', 'full_name' => 'test/fullname', 'description' => 'this is a test', 'html_url' => 'https://www.example.com', 'stargazers_count' => 1, 'language' => 'ruby'} }
  subject { FactoryGirl.build(:repo, stargazers_count: 10) }
  it { expect(subject.name).to eq "Test Repo" }
  it { expect(subject.full_name).to eq "test/test-repo" }
  it { expect(subject.description).to eq "This is a description." }
  it { expect(subject.url).to eq "https://github.com/repos/test-repo" }
  it { expect(subject.stargazers_count).to eq 10 }
  it { expect(subject.language).to eq 'ruby' }
  describe '.new_from_hash' do
    subject { Repo.new_from_hash(attributes_hash) }
    it { expect(subject.name).to eq attributes_hash['name'] }
    it { expect(subject.full_name).to eq attributes_hash['full_name'] }
    it { expect(subject.description).to eq attributes_hash['description'] }
    it { expect(subject.url).to eq attributes_hash['html_url'] }
    it { expect(subject.stargazers_count).to eq attributes_hash['stargazers_count'] }
    it { expect(subject.language).to eq 'ruby' }
  end
  describe "#to_json" do
    subject { Repo.new_from_hash(attributes_hash) }
    it { expect(subject.to_json).to eq attributes_hash.to_json }
  end
end