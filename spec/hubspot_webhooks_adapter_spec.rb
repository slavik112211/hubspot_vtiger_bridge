require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../hubspot_webhooks_adapter'
require File.dirname(__FILE__) + '/../vtiger_lead_custom_fields'
require File.dirname(__FILE__) + '/../vtiger_event_custom_fields'

describe "hubspot webhooks adapter" do
  describe 'to_vtiger_lead' do
    it "should transform hubspot lead to vtiger lead" do
      vtiger_lead = HubspotWebhooksAdapter.to_vtiger_lead(JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspotSingleLead.js')))
      vtiger_lead.should eql({'firstname' => 'John', 'lastname' => 'Doe', 'company' => 'HubSpot', 
                          'email' => 'johndoe@hubspot.com', VTigerLeadCustomFields::HUBSPOT_LEAD_ID => '8a40135230f21bdb0130f21c255c0007', 
                          VTigerLeadCustomFields::HUBSPOT_INDUSTRY => 'Software', 
                          VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => 'app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken=',
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
    
    it "should remove the protocol signature from hubspot URL" do
      vtiger_lead = HubspotWebhooksAdapter.to_vtiger_lead({'publicLeadLink' => 'https://app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken='})
      vtiger_lead[VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL].should == 'app.hubspot.com/leads/public/leadDetails?portalId=53&leadToken='
    end
  end
  
  describe 'extract event' do
    it 'should extract the conversion event information into vtiger-ready event structure' do
      vtiger_event = HubspotWebhooksAdapter.extract_event(JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspotSingleLead.js')))
      vtiger_event.should eql({'subject' => 'Website form filled', 
                                'eventstatus' => 'Held', 
                                'activitytype'=> 'Undefined', 
                                'description' => 'Form name: Boiler MACT Guide',
                                'date_start' => '24-10-2011',
                                'time_start' => '14:37',
                                'due_date' => '24-10-2011',
                                'time_end' => '14:37',
                                'duration_hours' => 0,
                                VTigerEventCustomFields::HUBSPOT_FORM_URL => 'info.era-environmental.com/epa-boiler-mact-summary-guide/Default.aspx?RewriteStatus=3&hsCtaTracking=8a33cba0-bd94-45c7-9bfa-7b4515566214%7C136e325e-df32-4552-96c1-8241f7fc70cc'
                      })
    end
    
    it "should return nil if the conversion event doesn't exist in incoming Hash" do
      empty = {'lastConversionEvent' => nil}
      vtiger_event = HubspotWebhooksAdapter.extract_event(empty)
      vtiger_event.should be_nil
    end
    
    it "should assign the date and time of event to vtiger using local vtiger's timezone" do
      HubspotWebhooksAdapter::VTIGER_TIMEZONE = 'America/Montreal'
      timezone = stub('timezone')
      timezone.should_receive(:strftime).with('%d-%m-%Y', Time.parse('2011-10-24 18:37:14 UTC'))
      timezone.should_receive(:strftime).with('%H:%M', Time.parse('2011-10-24 18:37:14 UTC'))
      TZInfo::Timezone.should_receive(:get).with('America/Montreal').and_return(timezone)
      HubspotWebhooksAdapter.extract_event(JSON.parse(IO.read(File.dirname(__FILE__) + '/fixtures/incomingLeadDataHubspotSingleLead.js')))
    end
  end
  
  describe "remove url protocol" do
    it 'should remove the protocol specification from URLs' do
      url_without_protocol = HubspotWebhooksAdapter.remove_url_protocol 'http://info.era-environmental.com/epa-boiler-mact-summary-guide/Default.aspx?RewriteStatus=3&hsCtaTracking=8a33cba0-bd94-45c7-9bfa-7b4515566214|136e325e-df32-4552-96c1-8241f7fc70cc'
      url_without_protocol.should == 'info.era-environmental.com/epa-boiler-mact-summary-guide/Default.aspx?RewriteStatus=3&hsCtaTracking=8a33cba0-bd94-45c7-9bfa-7b4515566214%7C136e325e-df32-4552-96c1-8241f7fc70cc'
      url_without_protocol = HubspotWebhooksAdapter.remove_url_protocol 'http://www.hubspot.com/'
      url_without_protocol.should == 'www.hubspot.com/'
    end
    
    it 'should escape special characters in URL string' do
      url_without_protocol = HubspotWebhooksAdapter.remove_url_protocol 'http://www.some.com?z=asdf|sdf'
      url_without_protocol.should == 'www.some.com?z=asdf%7Csdf'
    end
    
    it 'should return empty string whenever URL cannot be parsed' do
      url_without_protocol = HubspotWebhooksAdapter.remove_url_protocol nil
      url_without_protocol.should == ''
    end
  end
end