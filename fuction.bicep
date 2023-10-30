param azureServiceConnectionName string = 'serviceconnectionautomatic'

param deploymentScope string = 'dev'

param resourceGroupName string = 'my-test-dev'
param location string = 'East US'


resource serviceConnection 'Microsoft.Resources/serviceConnections@2019-03-01' = {
  name: azureServiceConnectionName
  location: location
  properties: {
    serviceType: 'AzureResourceManagement'
    authenticationType: 'ServicePrincipal'
    tenantId: subscription().tenantId
    subscriptionId: subscription().subscriptionId
    clientId: '1388a79b-94af-4633-9a95-1c747bba25ac'
    clientSecret: 'Uqm8Q~M6Isa90_2253FECvsa-ffL2Any06YQMa8a'
  }
}

resource deployment 'Microsoft.Resources/deployments@2021-04-01' = {
  name: 'DeployBicepFiles'
  location: location
  properties: {
    templateLink: {
      uri: 'https://dev.azure.com/azuredevopst/mytestdev/_apis/git/repositories/azure-dev/items/fuction.bicep?download=true'
    }
    parametersLink: {
      uri: 'https://dev.azure.com/azuredevopst/mytestdev/_apis/git/repositories/azure-dev/items/fuction.bicep.params?download=true'
    }
    mode: 'Incremental'
    deploymentScope: deploymentScope
    resourceGroupName: resourceGroupName
  }
}
