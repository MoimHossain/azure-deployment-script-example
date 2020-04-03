$resourceGroupName = "tailwind-resources-we"



New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateFile .\cli-azure-deploy.json