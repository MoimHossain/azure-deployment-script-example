

$msiName="cloudoven-aad-appreg-admin"
$msiObjectId = "4f7a282d-4987-0c10-b276-68905f"

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


Get-AzureADServiceAppRoleAssignment -ObjectId $GraphServicePrincipal.ObjectId | Where-Object {$_.PrincipalDisplayName -eq $msiName} 
