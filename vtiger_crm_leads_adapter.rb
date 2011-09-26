require 'rubygems'
require 'digest/md5'
require 'json'
require 'httpclient'
require File.dirname(__FILE__) + '/vtiger_lead_custom_fields'

class VTigerCRMLeadsAdapter
  ADDRESS = 'http://www.era-intra.com/crm/webservice.php'
  USERNAME = 'Slavik'
  ACCESS_KEY = 'mGxbqCf1zbqlesfl'
  
  attr_accessor :session_id, :user_id, :temporary_user_access_key
  
  def initialize
    @httpclient ||= HTTPClient.new
    @session_id = nil
    @user_id = nil
  end
  
  def get_token
    response = JSON.parse(@httpclient.get_content(ADDRESS + '?operation=getchallenge&username='+USERNAME))
    response['result']['token']
  end
  
  def login
    token = get_token
    generated_key = Digest::MD5.hexdigest(token + ACCESS_KEY)
    response = @httpclient.post(ADDRESS,{'operation' => 'login', 'username' => USERNAME, 'accessKey' => generated_key})
    response = JSON.parse(response.body)
    raise 'logon to vTiger failed' if response['success'] == false
    @session_id = response['result']['sessionName']
    @user_id = response['result']['userId']
  end
  
  def find_lead(hubspot_id)
    raise "not logged into vTiger" if @session_id == nil or @user_id == nil
    query = URI.encode("select * from Leads where " + VTigerLeadCustomFields::HUBSPOT_LEAD_ID + "='" + hubspot_id + "' limit 1;")
    response = JSON.parse(@httpclient.get_content(ADDRESS + '?operation=query&query=' + query + '&sessionName=' + @session_id))
    return response['result'] == [] ? nil : response['result'][0]
  end
  
  def create_lead(lead)
    raise "not logged into vTiger" if @session_id == nil or @user_id == nil
    lead['assigned_user_id'] = @user_id
    post_params = {'operation' => 'create', 'sessionName' => @session_id, 'elementType' => 'Leads', 'element' => JSON.generate(lead)}
    response = @httpclient.post(ADDRESS, post_params)
    raise "creation of lead in vTiger failed" if JSON.parse(response.body)['success'] == false
  end
  
  
end
