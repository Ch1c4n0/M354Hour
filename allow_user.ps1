@echo OFF

$TenantID = "_____"
$App_ID = "____"
$ThumbPrint = "____"
Connect-AzAccount -tenantid $TenantID -ApplicationId $App_ID -CertificateThumbprint $ThumbPrint

$secret = (Get-AzKeyVaultSecret -vaultName "___" -name "___") | select *
$Get_My_Scret = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret.SecretValue) 
$Display_My_Secret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Get_My_Scret) 


$User = "________.onmicrosoft.com"
$PWord = ConvertTo-SecureString "$Display_My_Secret" -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Connect-MsolService -Credential $Cred



Import-Csv c:\m365\name.csv |  ForEach {Set-MsolUser -UserPrincipalName $_.name -BlockCredential $false}



$timestamp = Get-Date -UFormat "%m%d%Y"

Import-Csv c:\m365\name.csv |  ForEach {Get-MsolUser -UserPrincipalName $_.name | select Name,UserPrincipalName, BlockCredential} | Out-File -FilePath c:\m365\output$timestamp.txt
