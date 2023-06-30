resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties": true,
        "properties": {
            "Domain": {
                "description": "The Service Now instance domain e.g. https://*domain*.service-now.com",
                "type": "string"
            }
        },
        "type": "object"
    })
    contract_output = jsonencode({
        "additionalProperties": true,
        "properties": {
            "result": {
                "items": {
                    "additionalProperties": true,
                    "properties": {
                        "description": {
                            "type": "string"
                        },
                        "sys_id": {
                            "type": "string"
                        }
                    },
                    "title": "Item 1",
                    "type": "object"
                },
                "type": "array"
            }
        },
        "type": "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "https://$${input.Domain}.service-now.com/api/now/table/incident?sysparm_query=u_major_incident%3Dtrue&sysparm_limit=5"
        
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}