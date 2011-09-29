require 'json'
require 'uri'
require File.dirname(__FILE__) + '/vtiger_lead_custom_fields'

module HubspotWebhooksAdapter
  def HubspotWebhooksAdapter.to_vtiger_lead hubspot_lead
    lead_link = ''
    if !hubspot_lead['publicLeadLink'].nil? and !hubspot_lead['publicLeadLink'].empty? 
      lead_link = URI.parse(hubspot_lead['publicLeadLink'])
      lead_link = lead_link.host + lead_link.path + '?' + lead_link.query
    end
    {'firstname' => hubspot_lead['firstName'] || '', 
      'lastname' => hubspot_lead['lastName'] || '', 
      'company' => hubspot_lead['company'] || '', 
      'email' => hubspot_lead['email'] || '', 
      VTigerLeadCustomFields::HUBSPOT_LEAD_ID => hubspot_lead['guid'] || '', 
      VTigerLeadCustomFields::HUBSPOT_INDUSTRY => hubspot_lead['industry'] || '', 
      VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => lead_link,
      'phone' => hubspot_lead['phone'] || '',
      VTigerLeadCustomFields::HUBSPOT_MESSAGE => hubspot_lead['message'] || '',
      'designation' => hubspot_lead['jobTitle'] || '',
      'website' => hubspot_lead['website'] || ''
      }
  end
end