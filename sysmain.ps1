# Desativar SysMain
Write-Host "`n[+] Desativando SysMain (Superfetch)..."
try {
    Set-Service -Name "SysMain" -StartupType Disabled
    Stop-Service -Name "SysMain"
    Write-Host "✅ SysMain desativado com sucesso!"
} catch {
    Write-Host "❌ Erro ao desativar SysMain: $($_.Exception.Message)"
}