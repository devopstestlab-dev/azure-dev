resource symbolicname 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: 'string'
  parent: resourceSymbolicName
  properties: {
    annotations: [
      any
    ]
    connectVia: {
      parameters: {}
      referenceName: 'string'
      type: 'IntegrationRuntimeReference'
    }
    description: 'string'
    parameters: {}
    type: 'string'
    // For remaining properties, see LinkedService objects
  }
}
type: 'AzureBlobStorage'
  typeProperties: {
    accountKey: {
      secretName: any()
      secretVersion: any()
      store: {
        parameters: {}
        referenceName: 'string'
        type: 'LinkedServiceReference'
      }
      type: 'string'
    }
    accountKind: 'string'
    authenticationType: 'string'
    azureCloudType: any()
    connectionString: any()
    containerUri: any()
    credential: {
      referenceName: 'string'
      type: 'CredentialReference'
    }
    encryptedCredential: 'string'
    sasToken: {
      secretName: any()
      secretVersion: any()
      store: {
        parameters: {}
        referenceName: 'string'
        type: 'LinkedServiceReference'
      }
      type: 'string'
    }
    sasUri: any()
    serviceEndpoint: 'string'
    servicePrincipalId: any()
    servicePrincipalKey: {
      type: 'string'
      // For remaining properties, see SecretBase objects
    }
    tenant: any()
  }
