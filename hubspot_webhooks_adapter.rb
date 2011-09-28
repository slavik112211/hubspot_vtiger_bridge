require 'json'
require File.dirname(__FILE__) + '/vtiger_lead_custom_fields'

module HubspotWebhooksAdapter
  def HubspotWebhooksAdapter.to_vtiger_lead hubspot_lead
    {'firstname' => hubspot_lead['firstName'], 
      'lastname' => hubspot_lead['lastName'], 
      'company' => hubspot_lead['company'], 
      'email' => hubspot_lead['email'], 
      VTigerLeadCustomFields::HUBSPOT_LEAD_ID => hubspot_lead['guid'], 
      VTigerLeadCustomFields::HUBSPOT_INDUSTRY => hubspot_lead['industry'], 
      VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => hubspot_lead['publicLeadLink'],
      'phone' => hubspot_lead['phone'],
      VTigerLeadCustomFields::HUBSPOT_MESSAGE => hubspot_lead['message'],
      'designation' => hubspot_lead['jobTitle'],
      'website' => hubspot_lead['website']
      }
  end
end