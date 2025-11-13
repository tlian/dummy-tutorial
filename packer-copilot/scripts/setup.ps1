# scripts/setup.ps1
# Minimal post-install config. Customize as needed.

# Ensure we can run scripts freely during provisioning
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Show file extensions and hidden items for admins (quality of life)
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0 -PropertyType DWord -Force | Out-Null

# Marker file
'Provisioned at {0:u}' -f (Get-Date) | Out-File -FilePath C:\Provisioned.txt -Encoding utf8
