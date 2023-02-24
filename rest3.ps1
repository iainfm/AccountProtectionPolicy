Import-Module Microsoft.Graph.DeviceManagement
$DYN_User_LA_Accounts_SID = "S-1-12-1-1275617162-1121960982-2576807863-2205804207"
#$User = 'AzureAD\\DA_iain.mclaren@DVSA.GOV.UK'
$DaUserUpn = 'DA_Iain.McLaren@DVSA.GOV.UK'
$User = 'AzureAD\\' + $DaUserUpn.ToLower()
$User = 'S-1-5-21-565669392-213581919-1543857936-133161'
$User

$params = "{
    `"description`":`"Created by Powershell`",
    `"name`":`"Device Admin - Test User on Test Device`",
    `"platforms`":`"windows10`",
    `"priorityMetaData`": null,
    `"roleScopeTagIds`": [
        `"0`"
        ],
    `"settingCount`": 1,
    `"technologies`":`"mdm`",
    `"templateReference`": {
        `"templateId`":`"22968f54-45fa-486c-848e-f8224aa69772_1`",
        `"templateFamily`":`"endpointSecurityAccountProtection`",
        `"templateDisplayName`":`"Local user group membership`",
        `"templateDisplayVersion`":`"Version 1`"
    },
    `"settings`": [
        {
            `"id`":`"0`",
            `"settingInstance`": {
                `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance`",
                `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure`",
                `"settingInstanceTemplateReference`": {
                    `"settingInstanceTemplateId`":`"de06bec1-4852-48a0-9799-cf7b85992d45`"
                },        
            `"groupSettingCollectionValue`": [
                {`"settingValueTemplateReference`": null,`"children`": [
                    {
                        `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance`",
                        `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup`",
                        `"settingInstanceTemplateReference`": {
                            `"settingInstanceTemplateId`":`"76fa254e-cbdb-4718-8bdd-cd41e57caa02`"
                            },
                        `"groupSettingCollectionValue`": [
                                {
                                    `"settingValueTemplateReference`": null,`"children`": [
                                        {
                                            `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance`",
                                            `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_userselectiontype`",
                                            `"settingInstanceTemplateReference`": null,`"choiceSettingValue`": {
                                                `"settingValueTemplateReference`": null,
                                                `"value`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_userselectiontype_users`",
                                                `"children`": [
                                                        {
                                                            `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance`",
                                                            `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_users`",
                                                            `"settingInstanceTemplateReference`": null,`"simpleSettingCollectionValue`": [
                                                                {
                                                                    `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationStringSettingValue`",
                                                                    `"settingValueTemplateReference`": null,
                                                                    `"value`":`"$DYN_User_LA_Accounts_SID`"
                                                                },
                                                                {
                                                                    `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationStringSettingValue`",
                                                                    `"settingValueTemplateReference`": null,
                                                                    `"value`":`"$User`"
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                }
                                            },
                                            {
                                                `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance`",
                                                `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_action`",
                                                `"settingInstanceTemplateReference`": null,`"choiceSettingValue`": {
                                                    `"settingValueTemplateReference`": null,
                                                    `"value`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_action_add_restrict`",
                                                    `"children`": []
                                                }
                                            },
                                            {
                                                `"@odata.type`":`"#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance`",
                                                `"settingDefinitionId`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_desc`",
                                                `"settingInstanceTemplateReference`": null,`"choiceSettingCollectionValue`": [
                                                    {
                                                        `"settingValueTemplateReference`": null,`"value`":`"device_vendor_msft_policy_config_localusersandgroups_configure_groupconfiguration_accessgroup_desc_administrators`",
                                                        `"children`": []
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        }
    ]
}"

$NewPolicy = New-MgDeviceManagementConfigurationPolicy -BodyParameter $params

# Assign the new policy to the group required
Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies('$($NewPolicy.Id)')/assign" `
  -Method "POST" `
  -ContentType "application/json" `
  -Body "{`"assignments`":[{`"target`":{`"@odata.type`":`"#microsoft.graph.groupAssignmentTarget`",`"groupId`":`"215f7d50-8131-4975-bede-af02fefee5d4`"}}]}" `
  -StatusCodeVariable StatusCode

Write-Output $StatusCode
