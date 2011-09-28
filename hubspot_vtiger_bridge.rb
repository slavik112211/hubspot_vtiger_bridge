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
    hubspot_adapter = HubspotWebhooksAdapter.new hubspot_lead
    lead_for_vtiger = hubspot_adapter.to_vtiger_lead
    vtiger_adapter = VTigerCRMLeadsAdapter.new
    vtiger_adapter.login
    lead_in_vtiger = vtiger_adapter.find_lead lead_for_vtiger[VTigerLeadCustomFields::HUBSPOT_LEAD_ID]
    #if lead_in_vtiger 
      print "Lead found in vTiger, Hubspot id=" + lead_in_vtiger[VTigerLeadCustomFields::HUBSPOT_LEAD_ID] + "\n"
    #else
      vtiger_adapter.create_lead lead_for_vtiger
    #end
  rescue Exception => error
    pp error
  end
end