ENV['RACK_ENV'] = 'test'

require 'server'
require 'rack/test'

describe 'Home Endpoints' do
  include Rack::Test::Methods

  def app
    GitStars
  end

  describe "GET /" do
    before(:each) { get "/" }
    it { expect(last_response).to be_ok }
  end
end