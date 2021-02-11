provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "policy-def" {
  name         = "Custom - No custom subscription owner roles are created"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - No custom subscription owner roles are created"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "General"
    }
  METADATA
  policy_rule  = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Authorization/roleDefinitions"
      },
      {
        "field": "Microsoft.Authorization/roleDefinitions/type",
        "equals": "CustomRole"
      },
      {
        "anyOf": [
          {
            "not": {
              "field": "Microsoft.Authorization/roleDefinitions/permissions[*].actions[*]",
              "notEquals": "*"
            }
          },
          {
            "not": {
              "field": "Microsoft.Authorization/roleDefinitions/permissions.actions[*]",
              "notEquals": "*"
            }
          }
        ]
      },
      {
        "anyOf": [
          {
            "not": {
              "field": "Microsoft.Authorization/roleDefinitions/assignableScopes[*]",
              "notIn": [
                "[concat(subscription().id,'/')]",
                "[subscription().id]",
                "/"
              ]
            }
          },
          {
            "not": {
              "field": "Microsoft.Authorization/roleDefinitions/assignableScopes[*]",
              "notLike": "/providers/Microsoft.Management/*"
            }
          }
        ]
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
  name                 = "Assgn - No custom subscription owner roles are created"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.policy-def.id
  description          = "Ensure that no custom subscription owner roles are created"
  display_name         = "Assgn - No custom subscription owner roles are created"
}

# resource "azurerm_role_definition" "policy-test" {
#   name  = "policy-custom-role-definition"
#   scope = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"

#   permissions {
#     actions     = ["*"]
#     not_actions = []
#   }

#   assignable_scopes = ["/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"]
# }

# resource "azurerm_role_assignment" "example" {
#   scope              = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
#   role_definition_id = azurerm_role_definition.policy-test.role_definition_resource_id
#   principal_id       = "63f9a5ab-99e9-4257-a4b6-17dd04895bd2"
# }
