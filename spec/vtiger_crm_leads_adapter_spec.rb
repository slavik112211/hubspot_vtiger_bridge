require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../vtiger_crm_leads_adapter'
require File.dirname(__FILE__) + '/../vtiger_lead_custom_fields'

describe 'vTigerCRM leads adapter' do

  before(:each) do
    @httpclient = stub()
    HTTPClient.stub(:new).and_return(@httpclient)
    @vtiger_leads_adapter = VTigerCRMLeadsAdapter.new
  end 

  describe 'login' do
  
    before(:each) do
      @httpclient.stub(:get_content).with(VTigerCRMLeadsAdapter::ADDRESS+'?operation=getchallenge&username='+VTigerCRMLeadsAdapter::USERNAME)
        .and_return('{"success":true,"result":{"token":"4e7d04176f046","serverTime":1316815895,"expireTime":1316816195}}')
      
    end
  
    it "should receive a token from vTiger" do
      token = @vtiger_leads_adapter.get_token
      token.should == "4e7d04176f046"
    end
    
    it "should login into vTiger" do
      Digest::MD5.should_receive(:hexdigest).with("4e7d04176f046"+VTigerCRMLeadsAdapter::ACCESS_KEY).and_return("generated key")
      response = stub('response', :body => '{"success":true,"result":{"sessionName":"704dd2184e7bafe64a2de","userId":"19x16","version":"0.22","vtigerVersion":"5.2.1"}}')
      @httpclient.should_receive(:post).with(VTigerCRMLeadsAdapter::ADDRESS, 
        {'operation' => 'login', 'username' => VTigerCRMLeadsAdapter::USERNAME, 'accessKey' => "generated key"})
        .and_return(response)
      @vtiger_leads_adapter.login
      @vtiger_leads_adapter.session_id.should == '704dd2184e7bafe64a2de'
      @vtiger_leads_adapter.user_id.should == '19x16'
    end
    
    it "should throw an error if login failed" do
      response = stub('response', :body => IO.read(File.dirname(__FILE__) + '/fixtures/loginFailedVTiger.js'))
      @httpclient.should_receive(:post).and_return(response)
      lambda { @vtiger_leads_adapter.login }.should raise_exception(Exception, "logon to vTiger failed")
    end
  end
  
  describe 'find_lead' do
    it "should not proceed with lead search if not logged in" do
      lambda{ @vtiger_leads_adapter.find_lead ''}.should raise_exception(Exception, "not logged into vTiger")
    end

    describe 'logged in' do
      before(:each) do
        @vtiger_leads_adapter.session_id = '704dd2184e7bafe64a2de'
        @vtiger_leads_adapter.user_id = '19x16'
      end
      
      it "should url-encode the query string" do
        hash = stub('hash', :[] => [])
        @httpclient.stub(:get_content)
        JSON.stub(:parse).and_return hash
        URI.should_receive(:encode).with("select * from Leads where "+VTigerLeadCustomFields::HUBSPOT_LEAD_ID+"='hubspot lead id' limit 1;")
          .and_return("url encoded query")
        @vtiger_leads_adapter.find_lead('hubspot lead id')
      end
      
      it "should return nil when nothing is found" do
        URI.stub(:encode).and_return('not_there')
        @httpclient.should_receive(:get_content).with(VTigerCRMLeadsAdapter::ADDRESS+'?operation=query&query=not_there&sessionName=704dd2184e7bafe64a2de')
          .and_return('{"success":true,"result":[]}')
        @vtiger_leads_adapter.find_lead('non existing hubspot lead id').should == nil
      end
      
      it "should return lead as hash" do
        response = IO.read(File.dirname(__FILE__) + '/fixtures/leadSearchResultFoundVTiger.js')
        URI.stub(:encode).and_return ''
        @httpclient.should_receive(:get_content).and_return(response)
        lead = @vtiger_leads_adapter.find_lead('existing hubspot lead id')
        lead['firstname'].should == 'Jessica'
        lead['lastname'].should == 'McCormick'
        lead['phone'].should == '973-972-8424'
        lead['email'].should == 'jessica.mccormick@umdj.edu'
      end
    end
  end
  
  describe "create_lead" do
    it "should not proceed with lead creation if not logged in" do
      lambda{ @vtiger_leads_adapter.create_lead 'lead'}.should raise_exception(Exception, "not logged into vTiger")
    end
    
    describe "logged in" do
      before(:each) do
        @vtiger_leads_adapter.session_id = '704dd2184e7bafe64a2de'
        @vtiger_leads_adapter.user_id = '19x16'
      end
      
      it "should send a post request for lead creation" do
        JSON.stub(:parse => '')
        response = stub('response', :body => 'some')
        #successful_response = stub("response", :body => IO.read(File.dirname(__FILE__) + '/fixtures/createLeadVtigerSuccess.js'))
        lead = {'firstname' => 'John', 'lastname' => 'Doe', 'company' => 'HubSpot', 
                        'email' => 'johndoe@hubspot.com', VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
                        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
                        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken='}
        
        post_params = {'operation' => 'create', 'sessionName' => @vtiger_leads_adapter.session_id, 'elementType' => 'Leads',
                        'element' => '{"firstname":"John","lastname":"Doe","company":"HubSpot","email":"johndoe@hubspot.com","cf_620":"8a40135230f21bdb0130f21c255c0007","cf_622":"Software","cf_623":"https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=","assigned_user_id":"19x16"}'}
        @httpclient.should_receive(:post).with(VTigerCRMLeadsAdapter::ADDRESS, post_params).and_return(response)
        @vtiger_leads_adapter.create_lead lead
      end
      
      it "should throw an error if save was unsuccessful" do
        response = stub('response', :body => IO.read(File.dirname(__FILE__) + '/fixtures/createLeadVtigerFailure.js'))
        @httpclient.should_receive(:post).and_return(response)
        lambda { @vtiger_leads_adapter.create_lead({})}.should raise_exception(Exception, "creation of lead in vTiger failed")
      end
    end
    
  end
end