param location string='westus'
param storageAccountName string = 'myExistingStorageAccountName'
param blobContainerName string = 'myExistingBlobContainerName'
param dataFactoryDataSetInName string = 'myExistingDataSetInName'
param dataFactoryLinkedServiceName string = 'myExistingLinkedServiceName'
param dataFactoryDataSetOutName string = 'myExistingDataSetOutName'
var pipelineName = 'myExistingPipelineName' // Replace 'YourPipelineName' with the actual name of your pipeline
var dataFactoryName = 'myExistingDataFactoryName'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' existing = {
  name: storageAccountName
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' existing = {
  name: '${storageAccountName}/default/${blobContainerName}'
}

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' existing = {
  name: dataFactoryName
}

resource dataFactoryLinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' existing = {
  parent: dataFactory
  name: dataFactoryLinkedServiceName
}

resource dataFactoryDataSetIn 'Microsoft.DataFactory/factories/datasets@2018-06-01' existing = {
  parent: dataFactory
  name: dataFactoryDataSetInName
}

resource dataFactoryDataSetOut 'Microsoft.DataFactory/factories/datasets@2018-06-01' existing = {
  parent: dataFactory
  name: dataFactoryDataSetOutName
}

resource dataFactoryPipeline 'Microsoft.DataFactory/factories/pipelines@2018-06-01' = {
  parent: dataFactory
  name: pipelineName
  properties: {
    activities: [
      {
        name: 'MyCopyActivity'
        type: 'Copy'
        typeProperties: {
          source: {
            type: 'BinarySource'
            storeSettings: {
              type: 'AzureBlobStorageReadSettings'
              recursive: true
            }
          }
          sink: {
            type: 'BinarySink'
            storeSettings: {
              type: 'AzureBlobStorageWriteSettings'
            }
          }
          enableStaging: false
        }
        inputs: [
          {
            referenceName: dataFactoryDataSetIn.name
            type: 'DatasetReference'
          }
        ]
        outputs: [
          {
            referenceName: dataFactoryDataSetOut.name
            type: 'DatasetReference'
          }
        ]
      }
    ]
  }
}
