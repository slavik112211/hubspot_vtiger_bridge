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
        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=',
        'phone' => '555-123-1230',
        VTigerLeadCustomFields::HUBSPOT_MESSAGE => 'hi there!',
        'designation' => 'CEO',
        'website' => 'www.hubspot.com'
        }
      @vtiger_adapter = stub('adapter', :login => nil, :session_id => '704dd2184e7bafe64a2de', :user_id => '19x16')
    end
    
    it "should create lead in vtiger if nothing found" do
      @vtiger_adapter.stub(:find_lead => nil)
      @vtiger_adapter.should_receive(:create_lead).with(@lead)
      VTigerCRMLeadsAdapter.stub(:new).and_return(@vtiger_adapter)
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
    
    it "should update lead in vtiger if already exists" do
      old_lead = {'id' => 'id', 'lastname' => 'Carmack'}
      lead_after_merge = {'id' => 'id',
        'firstname' => 'John', 
        'lastname' => 'Doe', 
        'company' => 'HubSpot', 
        'email' => 'johndoe@hubspot.com', 
        VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=',
        'phone' => '555-123-1230',
        VTigerLeadCustomFields::HUBSPOT_MESSAGE => 'hi there!',
        'designation' => 'CEO',
        'website' => 'www.hubspot.com'
        }
      @vtiger_adapter.stub(:find_lead => old_lead)
      VTigerCRMLeadsAdapter.should_receive(:assign_lead_properties).with(old_lead, @lead).and_return(lead_after_merge)
      @vtiger_adapter.should_receive(:update_lead).with(lead_after_merge)
      VTigerCRMLeadsAdapter.stub(:new).and_return(@vtiger_adapter)
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
  end
end