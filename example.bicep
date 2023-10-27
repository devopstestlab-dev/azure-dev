param location string='westus'

//---Data Factory
resource storage 'Microsoft.Storage/storageAccounts@2022-09-01'={
  name:'testdbdevaccount'
  location:location
  kind:'StorageV2'
  sku:{
    name:'Standard_GRS'
  }
  properties:{
    accessTier:'Hot'
    supportsHttpsTrafficOnly:true
    isHnsEnabled:true
  }
}
resource datafactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'Adf-bicep'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    globalParameters: {}
    publicNetworkAccess: 'Enabled'
  }
}
//--- Data Factory Linked Service
resource adls_linked_service 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: 'adflinkedservic'
  parent: datafactory
  properties: {
    annotations: []
    description: 'linked_service_for_adls'
    parameters: {}
    type: 'AzureBlobFS'
    typeProperties: {
      url: storage.properties.primaryEndpoints.dfs
      //encryptedCredential:storage.listKeys(storage.id).keys[0].value
      servicePrincipalCredential: {
        type: 'SecureString'
        value: 'gkd8Q~21dwWFdAsEtbRA8FSqGiCBgU35u4JM8cyC'
      }
      servicePrincipalId:'gkd8Q~21dwWFdAsEtbRA8FSqGiCBgU35u4JM8cyC'
      servicePrincipalCredentialType:'ServicePrincipalKey'
      azureCloudType:'AzurePublic'
      servicePrincipalKey: {
        type: 'SecureString'
        value: '<serviceprincipalKey>'
      }
      tenant: 'd2068f38-7912-4bde-b425-02c56c28c86f'      
    }
  }
}
