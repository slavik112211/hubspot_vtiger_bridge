require File.dirname(__FILE__) + '/spec_helper'

describe 'hubspot vtiger leads management integration' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end
  
  it "should login into vtiger" do
    vtiger_adapter = stub('adapter', :find_lead => nil, :create_lead => nil)
    vtiger_adapter.should_receive(:login)
    VTigerCRMLeadsAdapter.should_receive(:new).and_return(vtiger_adapter)
    post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
  end
  
  it "should search for lead from vtiger" do
    vtiger_adapter = stub('adapter', :login => nil, :create_lead => nil)
    vtiger_adapter.should_receive(:find_lead).with('8a40135230f21bdb0130f21c255c0007')
    VTigerCRMLeadsAdapter.stub(:new).and_return(vtiger_adapter)
    post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
  end
  
  describe 'logged into vtiger' do
    before(:each) do
      @lead = {'firstname' => 'John', 
        'lastname' => 'Doe', 
        'company' => 'HubSpot', 
        'email' => 'johndoe@hubspot.com', 
        VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken='}
    end
    
    it "should create lead in vtiger if nothing found" do
      vtiger_adapter = stub('adapter', :login => nil, :find_lead => nil)
      vtiger_adapter.should_receive(:create_lead).with(@lead)
      VTigerCRMLeadsAdapter.stub(:new).and_return(vtiger_adapter)
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
  end
end