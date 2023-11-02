// Parameters
param serviceConnectionName string = 'ServiceConnection-$(utcNow("yyyyMMddHHmmss"))'
param orgUrl string = 'https://dev.azure.com/azuredevopst'
param projectName string = 'mytestdev'
param servicePrincipalClientId string = '7ee9f5fd-1c76-463f-af74-d1fe37ac7cd8'
@secure()
param servicePrincipalClientSecret string 
param servicePrincipalTenantId string = 'd2068f38-7912-4bde-b425-02c56c28c86f'
param subscriptionId string = '7b44425c-979b-476a-9cca-cd73b2fcff42'
param location string = 'East US'

// Resource
resource serviceConnection 'Microsoft.DevOps/serviceconnections@2020-07-14-preview' = {
  name: serviceConnectionName
  location: location
  properties: {
    serviceConnectionParameters: {
      servicePrincipalId: servicePrincipalClientId
      servicePrincipalKey: servicePrincipalClientSecret
      tenantId: servicePrincipalTenantId
      subscriptionId: subscriptionId
      scopeLevel: 'Subscription'
    }
    serviceConnectionType: 'azurerm'
    projectId: projectName
    organizationUrl: orgUrl
  }
}

// Output
output serviceConnectionId string = serviceConnection.id
