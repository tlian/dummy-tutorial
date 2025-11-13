# scripts/winrm.ps1
# Enable WinRM for Packer provisioning
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

Enable-PSRemoting -SkipNetworkProfileCheck -Force

# Allow basic auth and unencrypted for bootstrap (Packer uses this initially)
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Open firewall for WinRM
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=yes

# Make sure the service is set to start automatically
Set-Service -Name WinRM -StartupType Automatic
Restart-Service -Name WinRM
