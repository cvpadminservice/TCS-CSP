provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - Data encryption is set to On on a SQL Database"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Data encryption is set to On on a SQL Database"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "SQL"
    }
  METADATA
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "field": "Microsoft.Sql/transparentDataEncryption.status",
        "notEquals": "Enabled"
      },
      "then": {
        "effect": "deny"
      }
    }
  POLICY_RULE

}

resource "azurerm_policy_assignment" "policy-assgn" {
  name                 = "Assgn - Data encryption is set to On on a SQL Database"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that Data encryption is set to On on a SQL Database"
  display_name         = "Assgn - Data encryption is set to On on a SQL Database"
}

