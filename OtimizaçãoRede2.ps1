# Desabilitar Otimização de Entrega
Write-Host "`n[+] Desativando Otimização de Entrega do Windows Update..."
try {
    # Para Windows 10/11 Home, geralmente é suficiente desabilitar via Registro
    # Esta é uma abordagem menos "intrusiva" do que Group Policy para muitos usuários
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 0 -Force -ErrorAction Stop

    # Para sistemas que usam Group Policy (Pro/Enterprise), você pode ajustar as políticas
    # No entanto, a alteração de registro é mais "universal" para usuários domésticos.
    # Se quiser algo mais abrangente para Group Policy (que exige gpedit.msc):
    # Set-GPRegistryValue -Name "Local Computer Policy" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -ValueName "DODownloadMode" -Type DWord -Value 0

    Write-Host "✅ Otimização de Entrega desativada com sucesso!"
} catch {
    Write-Host "❌ Erro ao desativar Otimização de Entrega: $($_.Exception.Message)"
}