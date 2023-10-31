param azureDevOpsOrgUrl string = 'https://dev.azure.com/azuredevopst'
param azureDevOpsProjectName string = 'mytestdev'
param serviceConnectionName string = 'myconnectionjj'
param resourceGroupName string = 'my-test-dev'
param subscriptionId string = '7b44425c-979b-476a-9cca-cd73b2fcff42'


var body = {
  data: {
    subscriptionId: subscriptionId
    subscriptionName: subscriptionId
    environment: 'AzureCloud'
    scopeLevel: 'Subscription'
    creationMode: 'Automatic'
  }
}

resource serviceConnection 'Microsoft.Azure.DevOps/azureservices@2020-07-14-preview' = {
  name: serviceConnectionName
  properties: {
    name: serviceConnectionName
    type: 'azurerm'
    url: '${azureDevOpsOrgUrl}/${azureDevOpsProjectName}/_settings/adminservices?resourceId=${resourceGroupName}'
    data: body.data
    authorization: {
      parameters: {
        tenantid: subscription().tenantId
        subscriptionid: subscriptionId
        
      }
    }
  }
}
