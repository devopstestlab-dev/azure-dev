resource aadServiceConnection 'Microsoft.DevOps/serviceEndpoints@2023-04-03' = {
  name: 'Azure AD'
  properties: {
    serviceEndpointType: 'AzureRm'
    authenticationType: 'AADServicePrincipal'
    subscriptionId: subscription().subscriptionId
    tenantId: parameters('d2068f38-7912-4bde-b425-02c56c28c86f')
    clientId: parameters('7ee9f5fd-1c76-463f-af74-d1fe37ac7cd8')
    clientSecret: parameters('lwE8Q~5fc-ACItwkA_963dSi~4wCqiTr_fVLzdda')
    armUrl: parameters('https://dev.azure.com/azuredevopst')
  }
}
