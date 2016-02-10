ENV['RACK_ENV'] = 'test'

require 'server'
require 'rack/test'

describe 'API Endpoints' do
  include Rack::Test::Methods

  def app
    GitStars
  end

  describe "GET /api/users/" do
    context 'valid username' do
      let(:username) { 'adambarber' }
      before(:each) { get "/api/users/#{username}" }
      it { expect(last_response).to be_ok }
      it { expect(JSON.parse(last_response.body)['username']).to eq username }
      it { expect(JSON.parse(last_response.body)['total_stars']).to eq 8 }
      it { expect(JSON.parse(last_response.body)['average_stars']).to eq 0 }
    end

    context '404 username' do
      let(:username) { 'werwerrew' }
      before(:each) { get "/api/users/#{username}" }
      it { expect(last_response.status).to eq 404 }
      it { expect(JSON.parse(last_response.body)['message']).to eq "No Github user by the username of werwerrew" }
    end

    context 'rate limit error' do
      let(:username) { 'ratelimit' }
      before(:each) { get "/api/users/#{username}" }
      it { expect(last_response.status).to eq 429 }
      it { expect(JSON.parse(last_response.body)['message']).to eq "Rate Limit Exceeded: Next reset at 2016-02-10T11:11:05-08:00" }
    end
  end
end