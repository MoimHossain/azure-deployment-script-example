$resourceGroupName = "tailwind-resources-we"



New-AzResourceGroupDeployment -WhatIf -ResourceGroupName $resourceGroupName `
  -TemplateFile .\cli-azure-deploy.json 