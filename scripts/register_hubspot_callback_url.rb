require 'httpclient'
require 'uri'
require 'digest/md5'
require 'json'
require 'pp'

HUBSPOT_ADDRESS = "https://hubapi.com/leads/v1/"
API_KEY = "your-api-key"
CALLBACK_URL = 'https://your-url-for-script.com'

http_client = HTTPClient.new
pp http_client.post(HUBSPOT_ADDRESS + 'callback-url?hapikey=' + API_KEY, {:url => CALLBACK_URL}).body
#pp http_client.get(HUBSPOT_ADDRESS + 'callback-url?hapikey=' + API_KEY).body
