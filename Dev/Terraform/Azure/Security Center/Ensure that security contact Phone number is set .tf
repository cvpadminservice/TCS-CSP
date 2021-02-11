provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - A security contact phone number should be provided"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - A security contact phone number should be provided"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "Security Center"
    }
  METADATA
  policy_rule  = <<REQ_PHONE
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Security/securityContacts"
      },
      {
        "field": "Microsoft.Security/securityContacts/phone",
        "exists": "true"
      },
      {
        "field": "Microsoft.Security/securityContacts/phone",
        "Equals": ""
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
REQ_PHONE
}

resource "azurerm_policy_assignment" "assgn-req-phone" {
  name                 = "Assgn - A security contact phone number should be provided"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that security contact Phone number is set "
  display_name         = "Assgn - A security contact phone number should be provided"
}

# resource "azurerm_security_center_contact" "policy-contact-test" {
#   email               = "contact@example.com"
#   phone               = "9876543210"
#   alert_notifications = true
#   alerts_to_admins    = true
# }
