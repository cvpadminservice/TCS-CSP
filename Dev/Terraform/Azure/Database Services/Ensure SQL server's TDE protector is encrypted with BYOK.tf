provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - TDE protector is encrypted with BYOK"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - TDE protector is encrypted with BYOK"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "SQL"
    }
  METADATA
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "not": {
          "allOf": [
            {
              "field": "Microsoft.Sql/servers/encryptionProtector/serverKeyType",
              "equals": "AzureKeyVault"
            },
            {
              "field": "Microsoft.Sql/servers/encryptionProtector/uri",
              "notEquals": ""
            },
            {
              "field": "Microsoft.Sql/servers/encryptionProtector/uri",
              "exists": "true"
            }
          ]
        }
      },
      "then": {
        "effect": "deny"
      }
    }
  POLICY_RULE

}

resource "azurerm_policy_assignment" "policy-assgn" {
  name                 = "Assgn - TDE protector is encrypted with BYOK"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure SQL server's TDE protector is encrypted with BYOK-Use your own key"
  display_name         = "Assgn - TDE protector is encrypted with BYOK"
}
