// main.bicep

param devOpsOrganizationName string
param patToken string

resource serviceConnection 'Microsoft.Resources/serviceConnections@2021-07-01' = {
  name: 'MyServiceConnection'
  properties: {
    serviceConnectionName: 'MyServiceConnection'
    serviceConnectionType: 'generic'
    description: 'Service connection for Azure DevOps'
    authorization:
    {
      parameters: {
        accessToken: patToken
      }
      scheme: 'PersonalAccessToken'
    }
  }
}

output serviceConnectionId string = serviceConnection.id
