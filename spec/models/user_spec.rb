require "models/user"

require "factories/user"
require "factories/repo"

describe User do
  let(:popular_repo) { FactoryGirl.build(:repo, name: 'Popular Repo', stargazers_count: 100) }
  let(:semi_popular_repo) { FactoryGirl.build(:repo, name: 'Semi Popular Repo', stargazers_count: 50) }
  let(:unpopular_repo) { FactoryGirl.build(:repo, name: 'Unpopular Repo', stargazers_count: 0) }

  subject { FactoryGirl.build(:user) }
  it { expect(subject.username).to eq "adambarber" }
  it { expect(subject.repos).to eq [] }

  describe ".with_username" do
    subject { User.with_username('adambarber') }
    it {expect(subject.username).to eq 'adambarber' }
    it {expect(subject.repos).to be_kind_of(Array) }
  end

  describe "#sorted_repos" do
    subject { FactoryGirl.build(:user, repos: [semi_popular_repo, unpopular_repo, popular_repo]) }

    it "should return repos sorted by stargazers_count" do
      expect(subject.repos).to eq([semi_popular_repo, unpopular_repo, popular_repo])
      expect(subject.sorted_repos).to eq([popular_repo, semi_popular_repo, unpopular_repo])
    end
  end

  describe "#total_stars" do
    context "with no repos" do
      subject { FactoryGirl.build(:user, repos: []) }
      it { expect(subject.total_stars).to eq 0 }
    end
    context "with repos" do
      subject { FactoryGirl.build(:user, repos: [semi_popular_repo, unpopular_repo, popular_repo]) }
      it { expect(subject.total_stars).to eq 150 }
    end
  end

  describe "#total_repos" do
    context "with no repos" do
      subject { FactoryGirl.build(:user, repos: []) }
      it { expect(subject.total_repos).to eq 0 }
    end
    context "with repos" do
      subject { FactoryGirl.build(:user, repos: [semi_popular_repo, unpopular_repo, popular_repo]) }
      it { expect(subject.total_repos).to eq 3 }
    end
  end

  describe "#average_stars" do
    context "with no repos" do
      subject { FactoryGirl.build(:user, repos: []) }
      it { expect(subject.average_stars).to eq 0 }
    end
    context "with repos" do
      subject { FactoryGirl.build(:user, repos: [semi_popular_repo, unpopular_repo, popular_repo]) }
      it { expect(subject.average_stars).to eq 50 }
    end
  end

  describe "#to_json" do
    context "with no repos" do
      subject { FactoryGirl.build(:user, repos: []) }
      let(:attributes) { {username: subject.username, repos: subject.sorted_repos, total_stars: subject.total_stars, average_stars: subject.average_stars, total_repos: subject.total_repos} }
      it { expect(subject.to_json).to eq(attributes.to_json) }
    end
    context "with repos" do
      subject { FactoryGirl.build(:user, repos: [semi_popular_repo, unpopular_repo, popular_repo]) }
      let(:attributes) { {username: subject.username, repos: subject.sorted_repos, total_stars: subject.total_stars, average_stars: subject.average_stars, total_repos: subject.total_repos} }
      it { expect(subject.to_json).to eq(attributes.to_json) }
    end
  end
end