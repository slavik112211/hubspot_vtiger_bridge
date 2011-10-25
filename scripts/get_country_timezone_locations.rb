require 'tzinfo'
require 'pp'

pp TZInfo::Country.get('CA').zone_identifiers