param location string = 'westus'
param storageAccountName string = 'devstorageforazure'
param blobContainerName string = 'rahulblob'
param dataFactoryDataSetInName string = 'todaydevdatsetdemott'
param dataFactoryLinkedServiceName string = 'todevlinkedservydemo'
param dataFactoryDataSetOutName string = 'rgsrgrhr'
var pipelineName = 'todevpipelinedemo'
var dataFactoryName = 'rkkllidatafactory'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' existing = {
  name: storageAccountName
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' existing = {
  name: '${storageAccountName}/default/${blobContainerName}'
}

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' existing = {
  name: dataFactoryName
}

resource dataFactoryLinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  parent: dataFactory
  name: dataFactoryLinkedServiceName
  properties: {
    type: 'AzureBlobStorage'
    typeProperties: {
      connectionString: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value}'
    }
  }
}

resource dataFactoryDataSetIn 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  parent: dataFactory
  name: dataFactoryDataSetInName
  properties: {
    linkedServiceName: {
      referenceName: dataFactoryLinkedService.name
      type: 'LinkedServiceReference'
    }
    type: 'Binary'
    typeProperties: {
      location: {
        type: 'AzureBlobStorageLocation'
        container: blobContainerName
        folderPath: 'input'
        fileName: 'emp.txt'
      }
    }
  }
}

resource dataFactoryDataSetOut 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  parent: dataFactory
  name: dataFactoryDataSetOutName
  properties: {
    linkedServiceName: {
      referenceName: dataFactoryLinkedService.name
      type: 'LinkedServiceReference'
    }
    type: 'Binary'
    typeProperties: {
      location: {
        type: 'AzureBlobStorageLocation'
        container: blobContainerName
        folderPath: 'output'
      }
    }
  }
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
