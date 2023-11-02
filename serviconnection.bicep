param location string = 'eastus'
param serviceConnectionName string = 'test'
param projectName string = 'mytestdev'
param servicePrincipalId string = '7ee9f5fd-1c76-463f-af74-d1fe37ac7cd8'
param servicePrincipalKey string = 'shh8Q~d78jIIhTYtDTxKy8akSIEzpgrMXS0vvbsM'
param servicePrincipalTenantId string = 'd2068f38-7912-4bde-b425-02c56c28c86f'

resource serviceConnection 'Microsoft.DevOps/serviceconnections@2020-07-14-preview' = {
 name: serviceConnectionName
 location: location
 properties: {
    serviceEndpointType: 'azurerm'
    projectName: projectName
    description: 'Service connection to connect AzureRM to Azure DevOps'
    authorization: {
      parameters: {
        serviceprincipalid: servicePrincipalId
        serviceprincipalkey: servicePrincipalKey
        tenantid: servicePrincipalTenantId
      }
      scheme: 'ServicePrincipal'
    }
    data: {
      subscriptionId: 'shh8Q~d78jIIhTYtDTxKy8akSIEzpgrMXS0vvbsM'
      subscriptionName: 'Pay-As-You-Go'
      environment: 'AzureCloud'
      scopeLevel: 'Subscription'
    }
 }
}

output serviceConnectionId string = serviceConnection.id
