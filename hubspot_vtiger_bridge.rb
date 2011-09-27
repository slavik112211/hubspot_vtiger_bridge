require 'sinatra'
require 'uri'
require 'json'
require 'pp'

post '/' do
  pp request.body.string + "_END_OF_PARAMS\n"
  hubspot_lead = JSON.parse(URI.decode(request.body.string))['1']
  pp hubspot_lead['firstName']
  pp hubspot_lead['lastName']
end