// example.bicep

param location string = 'East US'
param dataLinkServiceName string
param datasetName string

resource dataLinkService 'Microsoft.DataShare/dataLinkServices@2020-10-01-preview' = {
  name: dataLinkServiceName
  location: location
}

resource dataset 'Microsoft.DataShare/datasets@2020-10-01-preview' = {
  parent: dataLinkService
  name: datasetName
  location: location
  properties: {
    datasetType: 'AzureBlob',
    containerName: 'your-container-name',
    connectionString: 'your-storage-account-connection-string',
    // Add other dataset properties as needed
  }
}

output dataLinkServiceId string = dataLinkService.id
output datasetId string = dataset.id
