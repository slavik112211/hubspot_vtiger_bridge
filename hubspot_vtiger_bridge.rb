require 'rubygems'
require 'sinatra'

post '/' do
  "Hello world, it's #{Time.now} at the server!"
end