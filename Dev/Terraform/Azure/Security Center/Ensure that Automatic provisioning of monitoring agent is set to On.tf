provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - Automatic provisioning of monitoring agent is set to On"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Automatic provisioning of monitoring agent is set to On"
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "not": {
          "field": "Microsoft.Security/autoProvisioningSettings/autoProvision",
          "equals": "On"
        }
      },
      "then": {
        "effect": "deny"
      }
    }
  POLICY_RULE

}

resource "azurerm_policy_assignment" "policy-assgn" {
  name                 = "Assgn - Automatic provisioning of monitoring agent is set to On"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that Automatic provisioning of monitoring agent is set to On"
  display_name         = "Assgn - Automatic provisioning of monitoring agent is set to On"
}

# resource "azurerm_security_center_auto_provisioning" "test-policy" {
#   auto_provision = "Off"
# }
