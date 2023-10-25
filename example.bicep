@description('storage account name')
param storage_account_name string = 'st${uniqueString(resourceGroup().name)}'

@description('storage account location')
param location string = 'East US'

@description('resource group name')
param resource_group_name string = 'my-test-dev'

@description('subscription ID')
param subscription_id string = '7b44425c-979b-476a-9cca-cd73b2fcff42'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_account_name
  scope: subscription_id  // Set the scope to the subscription level
  location: location
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
  }
  sku: {
    name: 'Premium_LRS'
  }
}

output storageAccountId string = storageaccount.id
output subscriptionId string = subscription_id
output resourceGroupName string = resource_group_name
