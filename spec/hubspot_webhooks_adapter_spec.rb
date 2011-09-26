require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../hubspot_webhooks_adapter'
require File.dirname(__FILE__) + '/../vtiger_lead_custom_fields'

describe "hubspot webhooks adapter" do
  before(:each) do
    @hubspot_adapter = HubspotWebhooksAdapter.new(JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspotSingleLead.js')))
  end
  
  it "should transform hubspot lead to vtiger lead" do
    @hubspot_adapter.to_vtiger_lead.should eql({'firstname' => 'John', 'lastname' => 'Doe', 'company' => 'HubSpot', 
                        'email' => 'johndoe@hubspot.com', VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
                        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
                        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=',
                        'assigned_user_id' => ''})
                      end  
end