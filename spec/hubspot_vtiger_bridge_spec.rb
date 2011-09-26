require File.dirname(__FILE__) + '/spec_helper'

describe 'hubspot vtiger leads management integration' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should say hello" do
    post '/'
    last_response.should be_ok
    last_response.body.should match 'Hello worlds'
  end
end