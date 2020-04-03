

# cloudoven-aad-appreg-admin


# $TenantID="cac2cc32-7de9-4f3d-8d79-76375427b620"
# $subscriptionID="5db218ce-c9b4-4cca-9d16-058d3354c640"

# $ResourceGroup="cloudoven-managed-identities"

$msiName="cloudoven-aad-appreg-admin"
$msiObjectId = "4f7a282d-0c10-4987-b276-68905f50b3a3"

$GraphAppId = "00000002-0000-0000-c000-000000000000" #Windows Azure Active Directory
$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"

# Application.ReadWrite.All
# Application.ReadWrite.OwnedBy
# Directory.Read.All
# Directory.ReadWrite.All

$PermissionName = "Directory.ReadWrite.All"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}


New-AzureAdServiceAppRoleAssignment `
    -ObjectId $msiObjectId `
    -PrincipalId $msiObjectId  `
    -ResourceId $GraphServicePrincipal.ObjectId `
    -Id $AppRole.Id  

# Write-Output "Roles.. "
# Write-Host $AppRole
Get-AzureADServiceAppRoleAssignment -ObjectId $GraphServicePrincipal.ObjectId | Where-Object {$_.PrincipalDisplayName -eq $msiName} 

# ----------

# Creating User Assigned Identity 
# New-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup -Name $msiName


# Connect-AzureAD -TenantId $TenantID #Connected as GA

# $MSI = (Get-AzureADServicePrincipal -Filter "displayName eq '$msiName'")
# Start-Sleep -Seconds 10

# $GraphAppId = "00000002-0000-0000-c000-000000000000" #Windows Azure Active Directory
# $GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
# $PermissionName = "Directory.Read.All"
# $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
# New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.ObjectId -PrincipalId $MSI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id  

# #NOTE: The above assignment may indicate bad request or indicate failure but it has been noted that the permission assignment still succeeds and you can verify with the following command
# Get-AzureADServiceAppRoleAssignment -ObjectId $GraphServicePrincipal.ObjectId | Where-Object {$_.PrincipalDisplayName -eq $DisplayNameOfMSI} 