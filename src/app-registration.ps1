

$appName = "TailWind-App"
$appURI = "https://tailwind-app-we.azurewebsites.net"
$appReplyURLs = "https://tailwind-app-we.azurewebsites.net/signin-oidc"
if(!($myApp = Get-AzureADApplication -Filter "DisplayName eq '$($appName)'"  -ErrorAction SilentlyContinue))
{
    $myApp = New-AzureADApplication -DisplayName $appName -IdentifierUris $appURI -Homepage $appHomePageUrl -ReplyUrls $appReplyURLs   
}

Write-Output $myApp