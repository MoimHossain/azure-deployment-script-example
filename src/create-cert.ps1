# Creating self signed certificate for Service Principal authenticatio

$filePath = "C:\self-signed-certificate\cloudoven.pfx"
$pwd = "<<< SOME PASSWORD >>>"
$NotAfter = (Get-Date).AddYears(2) # Valid for 6 Years
$startDate = (Get-Date)
$endDate = (Get-Date).AddYears(1) # Valid for 6 Years
$thumb = (New-SelfSignedCertificate -DnsName "cloudoven.onmicrosoft.com" `
            -CertStoreLocation "cert:\LocalMachine\My"  `
            -KeyExportPolicy Exportable `
            -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
            -NotAfter $NotAfter).Thumbprint

$pwd = ConvertTo-SecureString -String $pwd -Force -AsPlainText
Export-PfxCertificate -cert "cert:\localmachine\my\$thumb" `
    -FilePath $filePath `
    -Password $pwd


$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate($filePath, $pwd)
$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

$application = New-AzureADApplication `
    -DisplayName "CloudOven-AppRegistration-Admin" `
    -IdentifierUris "https://moimhossain.com"

New-AzureADApplicationKeyCredential `
    -ObjectId $application.ObjectId `
    -StartDate $startDate `
    -EndDate $endDate `
    -CustomKeyIdentifier "ClientCertificateKey" `
    -Type AsymmetricX509Cert `
    -Usage Verify -Value $keyValue

$sp=New-AzureADServicePrincipal -AppId $application.AppId

Write-Output $application
Write-Output $sp

Write-Output $thumb

