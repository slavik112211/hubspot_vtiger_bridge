require 'net/http'
require 'uri'
require 'digest/md5'
require 'json'
require 'pp'

VTIGER_ADDRESS = 'http://www.your-vtiger.com/'
USERNAME = 'your-user-name'
USER_ACCESS_KEY = 'your-access-key'

response = JSON.parse(Net::HTTP.get(URI.parse(VTIGER_ADDRESS+'webservice.php?operation=getchallenge&username='+USERNAME)))
#{"success"=>true, "result"=>{"token"=>"4e7ba67589718", "serverTime"=>1316726389, "expireTime"=>1316726689}}
pp response
Process.exit if response['success'] != true

generated_key = Digest::MD5.hexdigest(response['result']['token'] + USER_ACCESS_KEY)
response = Net::HTTP.post_form(URI.parse(VTIGER_ADDRESS+'webservice.php'), 
                    {'operation' => 'login', 'username' => USERNAME, 'accessKey' => generated_key})
response = JSON.parse(response.body)
pp response
Process.exit if response['success'] != true

session_id = response['result']['sessionName']
user_id = response['result']['userId']

response = JSON.parse(Net::HTTP.get(URI.parse(VTIGER_ADDRESS+'webservice.php?operation=describe&elementType=Events&sessionName=' + session_id)))
response = JSON.pretty_generate(response)
File.open('eventStructureVtiger.js', 'w') {|f| f.write(response) }