param azureDevOpsOrgUrl string = 'https://dev.azure.com/azuredevopst'
param azureDevOpsProjectName string = 'mytestdev'
param serviceConnectionName string = 'myconnectionjj'
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
    displayName: serviceConnectionName
    endpointUrl: '${azureDevOpsOrgUrl}/${azureDevOpsProjectName}/_apis/serviceendpoint/endpoints/${serviceConnectionName}'
    scope: 'subscription'
    data: body.data
    authorization: {
      scheme: 'ServicePrincipal'
      parameters: {
        tenantid: subscription().tenantId
        serviceprincipalid: 'b7eb4c20-dcd4-4c18-bc99-1f6de9a9c35b'
        serviceprincipalkey: 'FL38Q~h_FqUfKDTn2qT66LpnFmSbFhCffODY.dr-'
        subscriptionid: subscriptionId
      }
    }
  }
}
