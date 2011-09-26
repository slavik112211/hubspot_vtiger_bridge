require 'json'
require File.dirname(__FILE__) + '/vtiger_lead_custom_fields'

class HubspotWebhooksAdapter
  def initialize hubspot_lead
    @hubspot_lead = hubspot_lead
  end

  def to_vtiger_lead
    {'firstname' => @hubspot_lead['firstName'], 
      'lastname' => @hubspot_lead['lastName'], 
      'company' => @hubspot_lead['company'], 
      'email' => @hubspot_lead['email'], 
      VTigerLeadCustomFields::HUBSPOT_LEAD_ID => @hubspot_lead['guid'], 
      VTigerLeadCustomFields::HUBSPOT_INDUSTRY => @hubspot_lead['industry'], 
      VTigerLeadCustomFields::HUBSPOT_PUBLIC_URL => @hubspot_lead['publicLeadLink'],
      'assigned_user_id' => ''}
  end
end