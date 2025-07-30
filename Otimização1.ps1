# Otimizacao leve para PCs 
Write-Host "===============================" -ForegroundColor Cyan
Write-Host " OTIMIZAÇÃO DO WINDOWS INICIADA " -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Ativar SysMain
Write-Host "`n[+] Ativando SysMain (Superfetch)..."
Set-Service -Name "SysMain" -StartupType Automatic
Start-Service -Name "SysMain"

# Ativar Compactacao
Write-Host "[+] Ativando Compactação de Memória..."
Enable-MMAgent -MemoryCompression
Restart-Service -Name "SysMain"

# Acelerar desligamento
Write-Host "[+] Acelerando desligamento..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -Value "2000"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value "2000"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value "1"

Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage



Write-Host "`n✅ Otimizações aplicadas com sucesso!"
Write-Host "🔁 Reinicie o PC para aplicar todas as mudanças." -ForegroundColor Yellow
