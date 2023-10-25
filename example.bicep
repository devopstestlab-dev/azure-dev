@description('storage account name')
param storage_account_name string = 'st${uniqueString(resourceGroup().name)}'

@description('storage account location')
param location string = 'East US' 

@description('resource group name')
param resource_group_name string = 'DefaultResourceGroup-EUS'

@description('subscription ID')
param subscription_id string = '7b44425c-979b-476a-9cca-cd73b2fcff42'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
  }
  sku: {
    name: 'Premium_LRS'
  }
}

output storageAccountId string = storageaccount.id
