require File.dirname(__FILE__) + '/spec_helper'

describe 'hubspot vtiger leads management integration' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end
  
  it "should login into vtiger" do
    vtiger_adapter = stub('adapter', :find_lead => {'id' => nil}, :create_lead => nil, :create_event => nil, :update_lead => nil)
    HubspotWebhooksAdapter.stub(:extract_event, :to_vtiger_lead)
    vtiger_adapter.should_receive(:login)
    VTigerCRMLeadsAdapter.should_receive(:new).and_return(vtiger_adapter)
    post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
  end
  
  it "should search for lead from vtiger" do
    HubspotWebhooksAdapter.stub(:extract_event)
    vtiger_adapter = stub('adapter', :login => nil, :create_lead => nil, :create_event => nil, :update_lead => nil)
    vtiger_adapter.should_receive(:find_lead).with('8a40135230f21bdb0130f21c255c0007').and_return({'id' => nil})
    VTigerCRMLeadsAdapter.stub(:new).and_return(vtiger_adapter)
    post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
  end
  
  it "should extract a conversion event from incoming data" do
    vtiger_adapter = stub('adapter', :find_lead => {'id' => nil}, :create_lead => nil, :update_lead => nil, :login => nil, :create_event => nil)
    VTigerCRMLeadsAdapter.should_receive(:new).and_return(vtiger_adapter)
    incoming_data = JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))['1']
    HubspotWebhooksAdapter.should_receive(:extract_event).with(incoming_data)
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
      HubspotWebhooksAdapter.stub(:extract_event)
      @vtiger_adapter.stub(:find_lead => nil, :create_event => nil)
      @vtiger_adapter.should_receive(:create_lead).with(@lead).and_return({'id' => nil})
      VTigerCRMLeadsAdapter.stub(:new).and_return(@vtiger_adapter)
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
    
    it 'should create an event in vtiger and assign it to newly created lead' do
      vtiger_adapter = stub('adapter', :find_lead => nil, :create_lead => {'id' => '2x531'}, :update_lead => nil, :login => nil)
      VTigerCRMLeadsAdapter.stub(:new => vtiger_adapter)
      HubspotWebhooksAdapter.stub(:extract_event => {:form => 'some form'})
      vtiger_adapter.should_receive(:create_event).with('2x531', {:form => 'some form'})
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
      HubspotWebhooksAdapter.stub(:extract_event)
      @vtiger_adapter.stub(:find_lead => old_lead, :create_event => nil)
      VTigerCRMLeadsAdapter.should_receive(:assign_lead_properties).with(old_lead, @lead).and_return(lead_after_merge)
      @vtiger_adapter.should_receive(:update_lead).with(lead_after_merge)
      VTigerCRMLeadsAdapter.stub(:new).and_return(@vtiger_adapter)
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
    
    it 'should create an event in vtiger and assign it to updated lead' do
      vtiger_adapter = stub('adapter', :find_lead => {'id' => '2x531'}, :create_lead => nil, :update_lead => {'id' => '2x531'}, :login => nil)
      VTigerCRMLeadsAdapter.stub(:new => vtiger_adapter)
      HubspotWebhooksAdapter.stub(:extract_event => {:form => 'some form'})
      vtiger_adapter.should_receive(:create_event).with('2x531', {:form => 'some form'})
      post '/', URI.encode(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspot.js'))
    end
  end
end