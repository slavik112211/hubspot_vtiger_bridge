require File.join(File.dirname(__FILE__), '..', 'hubspot_vtiger_bridge.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'


# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
