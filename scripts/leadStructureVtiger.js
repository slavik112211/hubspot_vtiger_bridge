{
  "success": true,
  "result": {
    "label": "Leads",
    "name": "Leads",
    "createable": true,
    "updateable": true,
    "deleteable": true,
    "retrieveable": true,
    "fields": [
      {
        "name": "salutationtype",
        "label": "Salutation",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "firstname",
        "label": "First Name",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "lead_no",
        "label": "Lead No",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": false,
        "editable": false
      },
      {
        "name": "phone",
        "label": "Phone",
        "mandatory": false,
        "type": {
          "name": "phone"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "lastname",
        "label": "Last Name",
        "mandatory": true,
        "type": {
          "name": "string"
        },
        "nullable": false,
        "editable": true
      },
      {
        "name": "mobile",
        "label": "Mobile",
        "mandatory": false,
        "type": {
          "name": "phone"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "company",
        "label": "Company",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": false,
        "editable": true
      },
      {
        "name": "fax",
        "label": "Fax",
        "mandatory": false,
        "type": {
          "name": "phone"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "designation",
        "label": "Title",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true,
        "default": "SalesMan"
      },
      {
        "name": "email",
        "label": "Email",
        "mandatory": false,
        "type": {
          "name": "email"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "leadsource",
        "label": "Lead Source",
        "mandatory": false,
        "type": {
          "picklistValues": [
            {
              "label": "--None--",
              "value": "--None--"
            },
            {
              "label": "Cold Call",
              "value": "Cold Call"
            },
            {
              "label": "Existing Customer",
              "value": "Existing Customer"
            },
            {
              "label": "Self Generated",
              "value": "Self Generated"
            },
            {
              "label": "Employee",
              "value": "Employee"
            },
            {
              "label": "Partner",
              "value": "Partner"
            },
            {
              "label": "Public Relations",
              "value": "Public Relations"
            },
            {
              "label": "Direct Mail",
              "value": "Direct Mail"
            },
            {
              "label": "Conference",
              "value": "Conference"
            },
            {
              "label": "Trade Show",
              "value": "Trade Show"
            },
            {
              "label": "Web Site",
              "value": "Web Site"
            },
            {
              "label": "Word of mouth",
              "value": "Word of mouth"
            },
            {
              "label": "Other",
              "value": "Other"
            }
          ],
          "defaultValue": "--None--",
          "name": "picklist"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "website",
        "label": "Website",
        "mandatory": false,
        "type": {
          "name": "url"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "industry",
        "label": "Industry",
        "mandatory": false,
        "type": {
          "picklistValues": [
            {
              "label": "--None--",
              "value": "--None--"
            },
            {
              "label": "Apparel",
              "value": "Apparel"
            },
            {
              "label": "Banking",
              "value": "Banking"
            },
            {
              "label": "Biotechnology",
              "value": "Biotechnology"
            },
            {
              "label": "Chemicals",
              "value": "Chemicals"
            },
            {
              "label": "Communications",
              "value": "Communications"
            },
            {
              "label": "Construction",
              "value": "Construction"
            },
            {
              "label": "Consulting",
              "value": "Consulting"
            },
            {
              "label": "Education",
              "value": "Education"
            },
            {
              "label": "Electronics",
              "value": "Electronics"
            },
            {
              "label": "Energy",
              "value": "Energy"
            },
            {
              "label": "Engineering",
              "value": "Engineering"
            },
            {
              "label": "Entertainment",
              "value": "Entertainment"
            },
            {
              "label": "Environmental",
              "value": "Environmental"
            },
            {
              "label": "Finance",
              "value": "Finance"
            },
            {
              "label": "Food & Beverage",
              "value": "Food & Beverage"
            },
            {
              "label": "Government",
              "value": "Government"
            },
            {
              "label": "Healthcare",
              "value": "Healthcare"
            },
            {
              "label": "Hospitality",
              "value": "Hospitality"
            },
            {
              "label": "Insurance",
              "value": "Insurance"
            },
            {
              "label": "Machinery",
              "value": "Machinery"
            },
            {
              "label": "Manufacturing",
              "value": "Manufacturing"
            },
            {
              "label": "Media",
              "value": "Media"
            },
            {
              "label": "Not For Profit",
              "value": "Not For Profit"
            },
            {
              "label": "Recreation",
              "value": "Recreation"
            },
            {
              "label": "Retail",
              "value": "Retail"
            },
            {
              "label": "Shipping",
              "value": "Shipping"
            },
            {
              "label": "Technology",
              "value": "Technology"
            },
            {
              "label": "Telecommunications",
              "value": "Telecommunications"
            },
            {
              "label": "Transportation",
              "value": "Transportation"
            },
            {
              "label": "Utilities",
              "value": "Utilities"
            },
            {
              "label": "Other",
              "value": "Other"
            }
          ],
          "defaultValue": "--None--",
          "name": "picklist"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "leadstatus",
        "label": "Lead Status",
        "mandatory": false,
        "type": {
          "picklistValues": [
            {
              "label": "--None--",
              "value": "--None--"
            },
            {
              "label": "Attempted to Contact",
              "value": "Attempted to Contact"
            },
            {
              "label": "Cold",
              "value": "Cold"
            },
            {
              "label": "Contact in Future",
              "value": "Contact in Future"
            },
            {
              "label": "Contacted",
              "value": "Contacted"
            },
            {
              "label": "Hot",
              "value": "Hot"
            },
            {
              "label": "Junk Lead",
              "value": "Junk Lead"
            },
            {
              "label": "Lost Lead",
              "value": "Lost Lead"
            },
            {
              "label": "Not Contacted",
              "value": "Not Contacted"
            },
            {
              "label": "Pre Qualified",
              "value": "Pre Qualified"
            },
            {
              "label": "Qualified",
              "value": "Qualified"
            },
            {
              "label": "Warm",
              "value": "Warm"
            }
          ],
          "defaultValue": "--None--",
          "name": "picklist"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "annualrevenue",
        "label": "Annual Revenue",
        "mandatory": false,
        "type": {
          "name": "integer"
        },
        "nullable": true,
        "editable": true,
        "default": "0"
      },
      {
        "name": "rating",
        "label": "Rating",
        "mandatory": false,
        "type": {
          "picklistValues": [
            {
              "label": "--None--",
              "value": "--None--"
            },
            {
              "label": "Acquired",
              "value": "Acquired"
            },
            {
              "label": "Active",
              "value": "Active"
            },
            {
              "label": "Market Failed",
              "value": "Market Failed"
            },
            {
              "label": "Project Cancelled",
              "value": "Project Cancelled"
            },
            {
              "label": "Shutdown",
              "value": "Shutdown"
            }
          ],
          "defaultValue": "--None--",
          "name": "picklist"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "noofemployees",
        "label": "No Of Employees",
        "mandatory": false,
        "type": {
          "name": "integer"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "assigned_user_id",
        "label": "Assigned To",
        "mandatory": true,
        "type": {
          "name": "owner"
        },
        "nullable": false,
        "editable": true,
        "default": "0"
      },
      {
        "name": "yahooid",
        "label": "Yahoo Id",
        "mandatory": false,
        "type": {
          "name": "email"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "createdtime",
        "label": "Created Time",
        "mandatory": false,
        "type": {
          "name": "datetime"
        },
        "nullable": false,
        "editable": false
      },
      {
        "name": "modifiedtime",
        "label": "Modified Time",
        "mandatory": false,
        "type": {
          "name": "datetime"
        },
        "nullable": false,
        "editable": false
      },
      {
        "name": "lane",
        "label": "Street",
        "mandatory": false,
        "type": {
          "name": "text"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "code",
        "label": "Postal Code",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "city",
        "label": "City",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "country",
        "label": "Country",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "state",
        "label": "State",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "pobox",
        "label": "PO Box",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "description",
        "label": "Description",
        "mandatory": false,
        "type": {
          "name": "text"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "cf_617",
        "label": "oldid",
        "mandatory": false,
        "type": {
          "name": "double"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "cf_620",
        "label": "hubspotId",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "cf_621",
        "label": "Notes from hubspot",
        "mandatory": false,
        "type": {
          "name": "text"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "cf_622",
        "label": "Industry description",
        "mandatory": false,
        "type": {
          "name": "string"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "cf_624",
        "label": "Hubspot URL",
        "mandatory": false,
        "type": {
          "name": "url"
        },
        "nullable": true,
        "editable": true
      },
      {
        "name": "id",
        "label": "leadid",
        "mandatory": false,
        "type": {
          "name": "autogenerated"
        },
        "editable": false,
        "nullable": false,
        "default": ""
      }
    ],
    "idPrefix": "2",
    "isEntity": true,
    "labelFields": "lastname,firstname"
  }
}