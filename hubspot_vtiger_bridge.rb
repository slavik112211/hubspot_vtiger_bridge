require 'sinatra'
require 'uri'
require 'json'
require 'pp'
require File.dirname(__FILE__) + '/hubspot_webhooks_adapter'
require File.dirname(__FILE__) + '/vtiger_crm_leads_adapter'
require File.dirname(__FILE__) + '/vtiger_lead_custom_fields'

post '/' do
  begin
    hubspot_lead = JSON.parse(URI.decode(request.body.string))['1']
    lead_for_vtiger = HubspotWebhooksAdapter.to_vtiger_lead hubspot_lead
    event_for_vtiger = HubspotWebhooksAdapter.extract_event hubspot_lead
    vtiger_adapter = VTigerCRMLeadsAdapter.new
    vtiger_adapter.login
    lead_in_vtiger = vtiger_adapter.find_lead lead_for_vtiger[VTigerLeadCustomFields::HUBSPOT_LEAD_ID]
    if lead_in_vtiger 
      lead_for_vtiger = VTigerCRMLeadsAdapter.assign_lead_properties(lead_in_vtiger,lead_for_vtiger)
      vtiger_adapter.update_lead lead_for_vtiger
    else
      lead_in_vtiger = vtiger_adapter.create_lead lead_for_vtiger
    end
    vtiger_adapter.create_event(lead_in_vtiger['id'], event_for_vtiger)
  rescue Exception => error
    pp error
  end
end