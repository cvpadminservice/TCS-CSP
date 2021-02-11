provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - standard pricing tier is selected"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - standard pricing tier is selected"
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
        "equals": "Microsoft.Security/pricings"
      },
      {
        "field": "Microsoft.Security/pricings/pricingTier",
        "exists": "true"
      },
      {
        "field": "Microsoft.Security/pricings/pricingTier",
        "notEquals": "Standard"
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
  name                 = "Assgn - standard pricing tier is selected"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that standard pricing tier is selected"
  display_name         = "Assgn - standard pricing tier is selected"
}

# resource "azurerm_security_center_subscription_pricing" "example" {
#   tier          = "Standard"
#   resource_type = "VirtualMachines"
# }
