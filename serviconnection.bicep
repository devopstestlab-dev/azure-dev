param orgUrl string = 'https://dev.azure.com/azuredevopst'
param personalAccessToken string = '${{secrets.PATTOKEN}}'
param subscriptionId string = '${{secrets.AZURE_SUBSCRIPTIONID}}'
param subscriptionName string = 'Pay-As-You-Go'

resource serviceConnection 'Microsoft.DevOps/serviceConnections@2020-07-14-preview' = {
  properties: {
    name: subscriptionName
    serviceEndpointType: 'azurerm'
    serviceEndpointProjectReferences: [
      {
        projectReference: {
          id: subscriptionId
          name: subscriptionName
        }
        serviceEndpointReference: {
          id: '00000000-0000-0000-0000-000000000000'
          name: subscriptionName
        }
      }
    ]
    authorization: {
      scheme: 'Header'
      parameters: {
        Authorization: 'Basic ' + base64(personalAccessToken + ':' + subscriptionId)
      }
    }
  }
  location: 'eastus'
}
