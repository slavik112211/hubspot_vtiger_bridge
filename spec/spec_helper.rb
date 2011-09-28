require File.join(File.dirname(__FILE__), '..', 'hubspot_vtiger_bridge.rb')
require File.join(File.dirname(__FILE__), '..', 'vtiger_lead_custom_fields.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'uri'


# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
