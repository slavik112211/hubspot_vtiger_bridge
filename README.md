## Introduction

Hubspot\_vtiger\_bridge integrates [Hubspot](http://www.hubspot.com/) and [vtigerCRM](http://www.vtiger.com/) in order to push leads data from hubspot to vtigerCRM.
Hubspot provides the webhooks interface to their leads stream, i.e. Hubspot has the optional feature of pushing their leads data onto whatever 
URL provided. This script is able of receiving hubspot leads json data, converting it into vtigerCRM leads json format, pushing the data into 
vTigerCRM.
It was developed for internal use at [ERA Environmental Consulting Inc.](http://www.era-environmental.com/), later gladly released to public with the permission of copyright owners.


## Setup

### Showstopper
Hubspot\_vtiger\_bridge is based on [Hubspot webhooks API](http://docs.hubapi.com/wiki/Webhooks), which is only available
for Hubspot ['Enterprise' plan](http://www.hubspot.com/pricing/) customers. For now, Hubspot\_vtiger\_bridge doesn't have any logic to pull leads data from Hubspot,
it is only able of receiving what Hubspot emits to it's webhooks. 

### Hosting, registering URL with Hubspot
The script represents a [Sinatra](http://www.sinatrarb.com/) web-application, and has to be hosted on a public HTTPS URL. 
Hubspot webhooks will only push data onto HTTPS url, so pick your hosting accordingly. 
[Heroku](http://www.heroku.com/) hosting can be a good choice for this type of application. After obtaining the URL for application, it has to 
get registered with Hubspot webhooks. This can be done using scripts/register\_hubspot\_callback\_url.rb


### Adjusting lead properties
Before the use of script the conversion of lead properties between two systems has to be adjusted.
The mapping is specified in file hubspot\_webhooks\_adapter.rb, HubspotWebhooksAdapter.to\_vtiger\_lead static method.
After examining that file, you'll see that it depends on some field names that are defined in vtiger\_lead\_custom\_fields.rb.

When the script pushes the lead into vtiger, some properties of the lead object are saved into vtiger custom lead properties, 
and these have to be created in your vtiger installation. This can be done under Settings > Module Manager > Leads > Layout Editor, using the small '+' icon.
vTigerCRM will assign a new name to that JSON lead property, which can't be renamed and looks like this: 'cf\_620'.
The file vtiger\_lead\_custom\_fields.rb is responsible for representation of these custom field names in hubspot\_webhooks\_adapter.rb.
scripts/get\_vtiger\_lead\_structure.rb can be used to determine these custom names. The structure returned
should look like scripts/leadStructureVtiger.js.

Adjusting one of the fields is mandatory for correct script operation - hubspotId:

    {
      "name": "cf_620",
      "label": "hubspotId",
    }
  
'cf_620' has to be substituted for your value in vtiger\_lead\_custom\_fields.rb, as this property is used to make a decision if it's a new lead for vtiger,
or it already exists, and we only need to update it.

### Vtiger credentials/address
Setting credentials for vtiger is moved out of the code into environmental variables.
There are 3 envvars to set: VTIGER\_ACCESS\_KEY, VTIGER\_ADDRESS, VTIGER\_USERNAME.
When hosted on Heroku, setting of envvars can be done this way (in console from a folder where you've checked out the git project):

    heroku config:add VTIGER_ACCESS_KEY='your-access-key', VTIGER_ADDRESS='your-installation-url', VTIGER_USERNAME='your-username'

### Logging
Web-server logging can be used to check on correct setup. With Heroku hosting it can be done this way (in console from a folder where you've checked out the git project):

    heroku logs --tail

## Links

* [Hubspot Webhooks API](http://docs.hubapi.com/wiki/Webhooks)
* [Hubspot Leads API](http://docs.hubapi.com/wiki/Leads_API_Methods)
* [vTigerCRM API tutorials](http://wiki.vtiger.com/index.php/vtiger510:WebServices_tutorials)
* [vTigerCRM API reference](http://wiki.vtiger.com/index.php/vtiger510:Webservice_reference_manual)
* [Heroku quickstart](http://devcenter.heroku.com/articles/quickstart)
* [Hosting a sinatra application on Heroku](http://devcenter.heroku.com/articles/rack#sinatra)
* [Heroku server env vars](http://devcenter.heroku.com/articles/config-vars)

## Contact
Copyright 2011 Vyacheslav Derevyanko of ERA Environmental Consulting Inc., contact slavik2121[at]gmail.com, released under the MIT license
