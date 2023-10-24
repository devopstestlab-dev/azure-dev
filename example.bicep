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
    containerName: 'devcontainer',
    connectionString: 'DefaultEndpointsProtocol=https;AccountName=rahuk;AccountKey=oXAdvzWFfKwtiAwS9Msw3ZCAZh9IGQ49Rs+x9gNfMz1j8Y6SOka/rVjIh8mRG1rhGvq+eOK7QONk+AStXzHLsQ==;EndpointSuffix=' + environment('core.windows.net'),
    // Add other dataset properties as needed
  }
}

output dataLinkServiceId string = dataLinkService.id
output datasetId string = dataset.id
