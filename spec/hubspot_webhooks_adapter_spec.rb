require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../hubspot_webhooks_adapter'
require File.dirname(__FILE__) + '/../vtiger_lead_custom_fields'

describe "hubspot webhooks adapter" do
  it "should transform hubspot lead to vtiger lead" do
    vtiger_lead = HubspotWebhooksAdapter.to_vtiger_lead(JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspotSingleLead.js')))
    vtiger_lead.should eql({'firstname' => 'John', 'lastname' => 'Doe', 'company' => 'HubSpot', 
                        'email' => 'johndoe@hubspot.com', VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
                        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
                        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=',
                        'phone' => '555-123-1230',
                        VTigerLeadCustomFields::HUBSPOT_MESSAGE => 'hi there!',
                        'designation' => 'CEO',
                        'website' => 'www.hubspot.com'
                        })
  end
  
  it "should provide empty string values to properties if they don't exist in incoming Hash" do
    empty =  {"guid"=>nil, 
    "publicLeadLink"=>nil, 
    "firstName"=>nil, 
    "lastName"=>nil, 
    "jobTitle"=>nil, 
    "company"=>nil,
    "email"=>nil, 
    "phone"=>nil, 
    "website"=>nil, 
    "industry"=>nil,
    "message" => nil}
    
    vtiger_lead = HubspotWebhooksAdapter.to_vtiger_lead(empty)
    vtiger_lead.should eql({'firstname' => '', 'lastname' => '', 'company' => '', 
                        'email' => '', VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '', 
                        VTigerLeadCustomFields::HUBSPOT_INDUSTRY => '', 
                        VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => '',
                        'phone' => '',
                        VTigerLeadCustomFields::HUBSPOT_MESSAGE => '',
                        'designation' => '',
                        'website' => ''
                        })
  end
end