# Como Desabilitar um Usuário do Microsoft 365 por Horário

## Pré-requisito 

- ***Instalar o Azure CLI***
    - [Azure CLI on Windows](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
- ***Instalar o Powershell EXO 3 no computador que vai rodar o script***
   - [ExchangeOnlineManagement 3.4.0](https://www.powershellgallery.com/packages/ExchangeOnlineManagement/3.4.0)

## Comandos para teste do ***Key Vaults***


- Teste Key Vaults
  
   - Teste 1
     
     `(Get-AzKeyVaultSecret -vaultName "kvm365" -name "teacher") | select *`
     
   - Teste 2
 
      `$secret = (Get-AzKeyVaultSecret -vaultName "kvm365" -name "teacher") | select *`
        
      `$Get_My_Scret = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret.SecretValue)` 

      `$Display_My_Secret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Get_My_Scret) `

      `$Display_My_Secret`  


## Comandos para criar o ***Certificado*** no PC


- Comandos para criar o certificado
  
  - Criar Certificado
   
      `$Cert_Name = "M365_Cert"`
  
      `New-SelfSignedCertificate -DnsName $Cert_Name -CertStoreLocation Cert:\currentuser\My`
  
      `$MyCert = Get-ChildItem -Path "cert:\CurrentUser\My" | Where-Object {$_.Subject -match $Cert_Name}`
  
      `$Cert_TB = $MyCert.Thumbprint`
  
      `Export-Certificate -Cert "Cert:\CurrentUser\My\$Cert_TB" -FilePath C:\$Cert_Name.cer`

   - Testar Certificado
     
     `Get-ChildItem -Path 'cert:\CurrentUser\My' | Select Thumbprint,FriendlyName,NotAfter,Subject`

   - Importar Certificado

      `$cert = Get-ChildItem -Path Cert:\currentuser\My\Number_certificado`
     
      `Export-Certificate -Cert $cert -FilePath C:\m365\M365_Cert.cer`


 ## Comandos para testar a ***Aplicação***  

   - Teste da Aplicação

      `$TenantID = "_____"`
     
      `$App_ID = "____"`
     
      `$ThumbPrint = "____"`
     
      `Connect-AzAccount -tenantid $TenantID -ApplicationId $App_ID -CertificateThumbprint $ThumbPrint`

   - Teste da Aplicação com Azure Key Vaults


      `$TenantID = "_____"`
     
      `$App_ID = "____"`
     
      `$ThumbPrint = "____"`
     
      `Connect-AzAccount -tenantid $TenantID -ApplicationId $App_ID -CertificateThumbprint $ThumbPrint`

     

      `$secret = (Get-AzKeyVaultSecret -vaultName "kvm365" -name "teacher") | select *`
     
      `$Get_My_Scret = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret.SecretValue)`
     
      `$Display_My_Secret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Get_My_Scret)`
     


## Comandos para logar no tenant de M365 com a senha no Key Vaults


>`$TenantID = "_____"`

>`$App_ID = "____"`

>`$ThumbPrint = "____"`

>`Connect-AzAccount -tenantid $TenantID -ApplicationId $App_ID -CertificateThumbprint $ThumbPrint`



>>`$secret = (Get-AzKeyVaultSecret -vaultName "kvm365" -name "teacher") | select *`

>>`$Get_My_Scret = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret.SecretValue)` 

>>`$Display_My_Secret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Get_My_Scret)` 




>>>`$User = "________.onmicrosoft.com"`

>>>`$PWord = ConvertTo-SecureString "$Display_My_Secret" -AsPlainText -Force`

>>>`$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord`



>>>`Connect-MsolService -Credential $Cred`







 
  
