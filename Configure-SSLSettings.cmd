@echo off 
:: Refencing to https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn786418(v=ws.11)

:: REG ADD KeyName [/v ValueName | /ve] [/t Type] [/s Separator] [/d Data] [/f]
::         [/reg:32 | /reg:64]
:: 
::   KeyName  [\\Machine\]FullKey
::            Machine  Name of remote machine - omitting defaults to the
::                     current machine. Only HKLM and HKU are available on remote
::                     machines.
::            FullKey  ROOTKEY\SubKey
::            ROOTKEY  [ HKLM | HKCU | HKCR | HKU | HKCC ]
::            SubKey   The full name of a registry key under the selected ROOTKEY.
:: 
::   /v       The value name, under the selected Key, to add.
:: 
::   /ve      adds an empty value name (Default) for the key.
:: 
::   /t       RegKey data types
::            [ REG_SZ    | REG_MULTI_SZ | REG_EXPAND_SZ |
::              REG_DWORD | REG_QWORD    | REG_BINARY    | REG_NONE ]
::            If omitted, REG_SZ is assumed.
:: 
::   /s       Specify one character that you use as the separator in your data
::            string for REG_MULTI_SZ. If omitted, use "\0" as the separator.
:: 
::   /d       The data to assign to the registry ValueName being added.
:: 
::   /f       Force overwriting the existing registry entry without prompt.
:: 
::   /reg:32  Specifies the key should be accessed using the 32-bit registry view.
:: 
::   /reg:64  Specifies the key should be accessed using the 64-bit registry view.
:: 
:: Examples:
:: 
::   REG ADD \\ABC\HKLM\Software\MyCo
::     Adds a key HKLM\Software\MyCo on remote machine ABC
:: 
::   REG ADD HKLM\Software\MyCo /v Data /t REG_BINARY /d fe340ead
::     Adds a value (name: Data, type: REG_BINARY, data: fe340ead)
:: 
::   REG ADD HKLM\Software\MyCo /v MRU /t REG_MULTI_SZ /d fax\0mail
::     Adds a value (name: MRU, type: REG_MULTI_SZ, data: fax\0mail\0\0)
:: 
::   REG ADD HKLM\Software\MyCo /v Path /t REG_EXPAND_SZ /d ^%systemroot^%
::     Adds a value (name: Path, type: REG_EXPAND_SZ, data: %systemroot%)
::     Notice:  Use the caret symbol ( ^ ) inside the expand string


:: Use Strong Crypto Missing
:: https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography


:: Setting SSL Server Configurations
echo setting configuration registry path
set ChannelProtocolPath=HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols
echo working in '%ChannelProtocolPath%'

:: Disable SSL 2.0
set subKey=SSL 2.0
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 1 /f


:: Disable SSL 3.0
set subKey=SSL 3.0
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 1 /f

:: Disable TLS 1.0
set subKey=TLS 1.0
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 1 /f

:: Disable TLS 1.1
set subKey=TLS 1.1
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 1 /f

:: Enable TLS 1.2
set subKey=TLS 1.2
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 0 /f

:: Enable TLS 1.3
set subKey=TLS 1.3
echo Configuring %subKey% in '%ChannelProtocolPath%\%subKey%'

reg add "%ChannelProtocolPath%\%subKey%\Client" /v Enabled /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v Enabled /t REG_DWORD /d 1 /f
reg add "%ChannelProtocolPath%\%subKey%\Client" /v DisabledByDefault /t REG_DWORD /d 0 /f
reg add "%ChannelProtocolPath%\%subKey%\Server" /v DisabledByDefault /t REG_DWORD /d 0 /f



:: Configure .Net Cipher
:: Doc Links https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-server


set NETFrameworkRoot=HKLM\SOFTWARE\Microsoft\.NETFramework
set NETFrameworkVersion=v2.0.50727

reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f

set NETFrameworkVersion=v4.0.30319
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f

set NETFrameworkRoot=HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework
set NETFrameworkVersion=v2.0.50727

reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f

set NETFrameworkVersion=v4.0.30319
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f
reg add "%NETFrameworkRoot%\%NETFrameworkVersion%" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f


:: OCSP Stapling option
:: echo setting configuration registry path
:: set ChannelProtocolPath=HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL
:: echo working in '%ChannelProtocolPath%'

reg add %ChannelProtocolPath% /v EnableOcspStaplingForSni /t REG_DWORD /d 0 /f

:: Configure the use of TLS Cipher Suites and Ciphers

:: https://support.microsoft.com/de-de/help/3194197/considerations-for-disabling-and-replacing-tls-1-0-in-adfs

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /v Enabled /t REG_DWORD /d 00000000 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /v Enabled /t REG_DWORD /d 00000000 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /v Enabled /t REG_DWORD /d 00000000 

@echo on 