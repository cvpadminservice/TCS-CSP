provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - Ensure that Send email also to subscription owners is set to On"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Ensure that Send email also to subscription owners is set to On"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "Security Center"
    }
  METADATA
  policy_rule  = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Security/securityContacts"
      },
      {
        "field": "Microsoft.Security/securityContacts/alertsToAdmins",
        "exists": "true"
      },
      {
        "field": "Microsoft.Security/securityContacts/alertsToAdmins",
        "Equals": "Off"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY_RULE
}

resource "azurerm_policy_assignment" "policy-assgn" {
  name                 = "Assgn - Ensure that Send email also to subscription owners is set to On"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that Send email also to subscription owners is set to On"
  display_name         = "Assgn - Ensure that Send email also to subscription owners is set to On"
}

# resource "azurerm_security_center_contact" "policy-contact-test" {
#   email               = "contact@example.com"
#   phone               = "9876543210"
#   alert_notifications = true
#   alerts_to_admins    = true
# }
