

$appName = 'TailWind-App'
$appURI = 'https://tailwind-app-we.azurewebsites.net'
$appReplyURLs = 'https://tailwind-app-we.azurewebsites.net/signin-oidc'

if(!($tailwindApp = Get-AzureADApplication -Filter 'DisplayName eq ''$($appName)'''  -ErrorAction SilentlyContinue))
{
    $tailwindApp = New-AzureADApplication `
        -DisplayName $appName `
        -IdentifierUris $appURI `
        -Homepage $appHomePageUrl `
        -ReplyUrls $appReplyURLs   
}

Write-Output $tailwindApp