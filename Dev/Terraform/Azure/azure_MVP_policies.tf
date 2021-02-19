#------------------------------------------------------------------------------
# Name: MVP polices for azure.
# Version: 1.0
# Updated by: Subrata Maji
# Last modified: 19/02/2021
# Changes: Added 12 native policies of azure for MVP.
#------------------------------------------------------------------------------

provider "azurerm" {
  features {}
}

# policy: 1. No custom subscription owner roles are created
resource "azurerm_policy_definition" "azure_iam_noCustomSubsOwnerRoles_0001" {
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

resource "azurerm_policy_assignment" "azure_iam_noCustomSubsOwnerRoles_0001" {
  name                 = "Assgn - No custom subscription owner roles are created"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_iam_noCustomSubsOwnerRoles_0001.id
  description          = "Ensure that no custom subscription owner roles are created"
  display_name         = "Assgn - No custom subscription owner roles are created"
}

# policy: 2. Ensure that standard pricing tier is selected
resource "azurerm_policy_definition" "azure_security_standardPricingTier_0002" {
  name         = "Custom - Ensure that standard pricing tier is selected"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Ensure that standard pricing tier is selected"
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

resource "azurerm_policy_assignment" "azure_security_standardPricingTier_0002" {
  name                 = "Assgn - Ensure that standard pricing tier is selected"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_standardPricingTier_0002.id
  description          = "Ensure that standard pricing tier is selected"
  display_name         = "Assgn - Ensure that standard pricing tier is selected"
}

# policy: 3. Automatic provisioning of monitoring agent is set to On
resource "azurerm_policy_definition" "azure_security_autoProvisioningMonitoringAgent_0003" {
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

resource "azurerm_policy_assignment" "azure_security_autoProvisioningMonitoringAgent_0003" {
  name                 = "Assgn - Automatic provisioning of monitoring agent is set to On"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_autoProvisioningMonitoringAgent_0003.id
  description          = "Ensure that Automatic provisioning of monitoring agent is set to On"
  display_name         = "Assgn - Automatic provisioning of monitoring agent is set to On"
}

# policy: 4. Ensure that Security contact emails is set
resource "azurerm_policy_definition" "azure_security_contactEmailSet_0004" {
  name         = "Custom - Ensure that Security contact emails is set"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Ensure that Security contact emails is set"
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
        "field": "Microsoft.Security/securityContacts/email",
        "exists": "true"
      },
      {
        "field": "Microsoft.Security/securityContacts/email",
        "Equals": ""
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY_RULE
}

resource "azurerm_policy_assignment" "azure_security_contactEmailSet_0004" {
  name                 = "Assgn - Ensure that Security contact emails is set"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_contactEmailSet_0004.id
  description          = "Ensure that Security contact emails is set"
  display_name         = "Assgn - Ensure that Security contact emails is set"
}

# policy: 5. Ensure that security contact Phone number is set
resource "azurerm_policy_definition" "azure_security_contactPhoneNumberSet_0005" {
  name         = "Custom - Ensure that security contact Phone number is set"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Ensure that security contact Phone number is set"
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

resource "azurerm_policy_assignment" "azure_security_contactPhoneNumberSet_0005" {
  name                 = "Assgn - Ensure that security contact Phone number is set"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_contactPhoneNumberSet_0005.id
  description          = "Ensure that security contact Phone number is set"
  display_name         = "Assgn - Ensure that security contact Phone number is set"
}

# policy: 6. Send email notification for high severity alerts is On
resource "azurerm_policy_definition" "azure_security_emailNotificationHighSeverity_0006" {
  name         = "Custom - Send email notification for high severity alerts is On"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Send email notification for high severity alerts is On"
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
        "field": "Microsoft.Security/securityContacts/alertNotifications",
        "exists": "true"
      },
      {
        "field": "Microsoft.Security/securityContacts/alertNotifications",
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

resource "azurerm_policy_assignment" "azure_security_emailNotificationHighSeverity_0006" {
  name                 = "Assgn - Send email notification for high severity alerts is On"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_emailNotificationHighSeverity_0006.id
  description          = "To ensure the relevant people in your organization are notified when there is a potential security breach in one of your subscriptions, enable email notifications for high severity alerts in Security Center."
  display_name         = "Assgn - Send email notification for high severity alerts is On"
}

# policy: 7. Send email also to subscription owners is set to On
resource "azurerm_policy_definition" "azure_security_emailToSubscriptionOwner_0007" {
  name         = "Custom - Send email also to subscription owners is set to On"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Send email also to subscription owners is set to On"
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

resource "azurerm_policy_assignment" "azure_security_emailToSubscriptionOwner_0007" {
  name                 = "Assgn - Send email also to subscription owners is set to On"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_security_emailToSubscriptionOwner_0007.id
  description          = "To ensure your subscription owners are notified when there is a potential security breach in their subscription, set email notifications to subscription owners for high in Security Center."
  display_name         = "Assgn - Send email also to subscription owners is set to On"
}

# policy: 8. TDE on SQL databases should be enabled
resource "azurerm_policy_definition" "azure_database_dataEncryptionSqlDatabases_0008" {
  name         = "Custom - TDE on SQL databases should be enabled"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - TDE on SQL databases should be enabled"
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

resource "azurerm_policy_assignment" "azure_database_dataEncryptionSqlDatabases_0008" {
  name                 = "Assgn - TDE on SQL databases should be enabled"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_database_dataEncryptionSqlDatabases_0008.id
  description          = "ransparent data encryption should be enabled to protect data-at-rest and meet compliance requirements"
  display_name         = "Assgn - TDE on SQL databases should be enabled"
}

# policy: 9. Ensure SQL servers TDE protector is encrypted with BYOK
resource "azurerm_policy_definition" "azure_database_tdeProtectorEncryptedBYOK_0009" {
  name         = "Custom - Ensure SQL servers TDE protector is encrypted with BYOK"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom - Ensure SQL servers TDE protector is encrypted with BYOK"
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

resource "azurerm_policy_assignment" "azure_database_tdeProtectorEncryptedBYOK_0009" {
  name                 = "Assgn - Ensure SQL servers TDE protector is encrypted with BYOK"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_database_tdeProtectorEncryptedBYOK_0009.id
  description          = "Implementing Transparent Data Encryption (TDE) with your own key provides increased transparency and control over the TDE Protector, increased security with an HSM-backed external service, and promotion of separation of duties. This recommendation applies to organizations with a related compliance requirement."
  display_name         = "Assgn - Ensure SQL servers TDE protector is encrypted with BYOK"
}

# policy: 10. Web app is using the latest version of TLS encryption
resource "azurerm_policy_definition" "azure_appService_latestVersionTlsEncyptionWebapp_0010" {
  name         = "Custom - Web app is using the latest version of TLS encryption"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Custom - Web app is using the latest version of TLS encryption"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "App Service"
    }
  METADATA
  parameters   = <<PARAM
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "Disabled"
        ],
        "defaultValue": "AuditIfNotExists"
      }
    }
  PARAM
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Web/sites"
          },
          {
            "field": "kind",
            "like": "app*"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Web/sites/config",
          "name": "web",
          "existenceCondition": {
            "field": "Microsoft.Web/sites/config/minTlsVersion",
            "equals": "1.2"
          }
        }
      }
    }
  POLICY_RULE
}

resource "azurerm_policy_assignment" "azure_appService_latestVersionTlsEncyptionWebapp_0010" {
  name                 = "Assgn - Web app is using the latest version of TLS encryption"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_appService_latestVersionTlsEncyptionWebapp_0010.id
  description          = "Ensure that web app is using the latest version of TLS encryption"
  display_name         = "Assgn - Web app is using the latest version of TLS encryption"
}

# policy: 11. PHP version is the latest, if used to run the webapp
resource "azurerm_policy_definition" "azure_appService_latestPhpVersionWebapp_0011" {
  name         = "Custom - PHP version is the latest, if used to run the webapp"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Custom - PHP version is the latest, if used to run the webapp"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "App Service"
    }
  METADATA
  parameters   = <<PARAM
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "Disabled"
        ],
        "defaultValue": "AuditIfNotExists"
      },
      "PHPLatestVersion": {
        "type": "String",
        "metadata": {
          "displayName": "Latest PHP version",
          "description": "Latest supported PHP version for App Services"
        },
        "defaultValue": "7.4"
      }
    }
  PARAM
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Web/sites"
          },
          {
            "field": "kind",
            "like": "app*"
          },
          {
            "field": "kind",
            "contains": "linux"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Web/sites/config",
          "name": "web",
          "existenceCondition": {
            "anyOf": [
              {
                "field": "Microsoft.Web/sites/config/web.linuxFxVersion",
                "notContains": "PHP"
              },
              {
                "field": "Microsoft.Web/sites/config/web.linuxFxVersion",
                "equals": "[concat('PHP|', parameters('PHPLatestVersion'))]"
              }
            ]
          }
        }
      }
    }
  POLICY_RULE
}

resource "azurerm_policy_assignment" "azure_appService_latestPhpVersionWebapp_0011" {
  name                 = "Custom - PHP version is the latest, if used to run the webapp"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_appService_latestPhpVersionWebapp_0011.id
  description          = "Periodically, newer versions are released for PHP software either due to security flaws or to include additional functionality. Using the latest PHP version for web apps is recommended in order to take advantage of security fixes, if any, and/or new functionalities of the latest version. Currently, this policy only applies to Linux web apps."
  display_name         = "Custom - PHP version is the latest, if used to run the webapp"
}

# policy: 12. Ensure that Python version is the latest for web app
resource "azurerm_policy_definition" "azure_appService_latestPythonVersionWebapp_0012" {
  name         = "Custom - Ensure that Python version is the latest for web app"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Custom - Ensure that Python version is the latest for web app"
  metadata     = <<METADATA
    {
      "version": "1.0.1",
      "category": "App Service"
    }
  METADATA
  parameters   = <<PARAM
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "Disabled"
        ],
        "defaultValue": "AuditIfNotExists"
      },
      "LinuxPythonLatestVersion": {
        "type": "String",
        "metadata": {
          "displayName": "Linux Latest Python version",
          "description": "Latest supported Python version for App Services"
        },
        "defaultValue": "3.8"
      }
    }
  PARAM
  policy_rule  = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Web/sites"
          },
          {
            "field": "kind",
            "like": "app*"
          },
          {
            "field": "kind",
            "contains": "linux"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Web/sites/config",
          "name": "web",
          "existenceCondition": {
            "anyOf": [
              {
                "field": "Microsoft.Web/sites/config/web.linuxFxVersion",
                "notContains": "PYTHON"
              },
              {
                "field": "Microsoft.Web/sites/config/web.linuxFxVersion",
                "equals": "[concat('PYTHON|', parameters('LinuxPythonLatestVersion'))]"
              }
            ]
          }
        }
      }
    }
  POLICY_RULE
}

resource "azurerm_policy_assignment" "azure_appService_latestPythonVersionWebapp_0012" {
  name                 = "Custom - Ensure that Python version is the latest for web app"
  scope                = "/subscriptions/77ac2cdd-9a1d-4bbf-b77f-1394eec6e330"
  policy_definition_id = azurerm_policy_definition.azure_appService_latestPythonVersionWebapp_0012.id
  description          = "Periodically, newer versions are released for Python software either due to security flaws or to include additional functionality. Using the latest Python version for web apps is recommended in order to take advantage of security fixes, if any, and/or new functionalities of the latest version. Currently, this policy only applies to Linux web apps."
  display_name         = "Custom - Ensure that Python version is the latest for web app"
}
