require "services/repo_fetcher"

describe RepoFetcher do

  let(:single_page_username) { 'adambarber' }
  let(:multi_page_username) { 'jnunemaker' }
  let(:rate_limited_username) { 'ratelimit' }
  let(:not_found_username) { 'werwerrew' }

  subject { RepoFetcher.new(username) }
  context 'initial state' do
    let(:username) { single_page_username }
    it { expect(subject.username).to eq single_page_username }
    it { expect(subject.response).to eq nil }
    it { expect(subject.total_pages).to eq 1 }
    it { expect(subject.repos).to eq [] }
  end

  describe '.fetch_repos' do
    it { expect(RepoFetcher.fetch_repos(single_page_username)).to be_kind_of(Array) }
    it { expect(RepoFetcher.fetch_repos(single_page_username).first).to be_kind_of(Repo) }
  end

  describe '#fetch_repos' do
    context "from user with a single page of repos" do
      let(:username) { single_page_username }
      before(:each) { subject.fetch_repos }
      it "returns the correct number of repos" do
        expect(subject.repos.count).to eq 23
      end
      it "returns an array of repos" do
        expect(subject.repos).to be_kind_of(Array)
        expect(subject.repos.first).to be_kind_of(Repo)
      end
      it "returns the correct number of pages" do
        expect(subject.total_pages).to eq 1
      end
    end

    context "from user with multiple pages of repos" do
      let(:username) { multi_page_username }
      before(:each) { subject.fetch_repos }
      it "returns the correct number of repos" do
        expect(subject.repos.count).to eq 60
      end
      it "returns an array of repos" do
        expect(subject.repos).to be_kind_of(Array)
        expect(subject.repos.first).to be_kind_of(Repo)
      end
      it "returns the correct number of pages" do
        expect(subject.total_pages).to eq 2
      end
    end

    context "from non existant user" do
      let(:username) { not_found_username }
      it "raises an error" do
        expect{subject.fetch_repos}.to raise_error(RepoFetcher::NotFound)
      end
    end

    context "with rate limit error" do
      let(:username) { rate_limited_username }
      it "raises an error" do
        expect{subject.fetch_repos}.to raise_error(RepoFetcher::RateLimitExceeded)
      end
    end
  end
end