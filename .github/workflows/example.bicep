param location string = 'East US'
param dataFactoryName string
param pipelineName string
param linkedServiceName string
param datasetName string

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
}

resource linkedService 'Microsoft.DataFactory/factories/linkedServices@2018-06-01' = {
  name: linkedServiceName
  parent: dataFactory
  properties: {
    // Linked service properties, e.g., connectionString, type, etc.
  }
}

resource dataset 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: datasetName
  parent: dataFactory
  properties: {
    // Dataset properties, e.g., structure, linkedServiceName, type, etc.
  }
}

resource pipeline 'Microsoft.DataFactory/factories/pipelines@2018-06-01' = {
  name: pipelineName
  parent: dataFactory
  properties: {
    activities: [
      // Define your pipeline activities here
    ]
  }
}

output dataFactoryId string = dataFactory.id
output linkedServiceId string = linkedService.id
output datasetId string = dataset.id
output pipelineId string = pipeline.id
