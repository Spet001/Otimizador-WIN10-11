# Desativar serviços específicos
Write-Host "`n[+] Desativando serviços não essenciais..."

$servicesToDisable = @(
    "WbioSrvc",            # Serviço de Biometria do Windows
    "RmSvc",               # Gerenciador de Rádio
    "lfsvc",               # Serviço de Geolocation
    "DiagTrack",           # Experiência do Usuário e Telemetria Conectada (Diagnostic Tracking Service)
    "Fax"                  # Serviço de Fax
)

foreach ($service in $servicesToDisable) {
    try {
        Write-Host "    - Tentando desativar '$service'..."
        Get-Service -Name $service -ErrorAction Stop | Set-Service -StartupType Disabled -ErrorAction Stop
        Get-Service -Name $service -ErrorAction Stop | Stop-Service -ErrorAction SilentlyContinue
        Write-Host "      ✅ Serviço '$service' desativado com sucesso!"
    } catch {
        Write-Host "      ❌ Erro ao desativar '$service': $($_.Exception.Message)"
    }
}

Write-Host "`n✅ Processo de otimização de serviços concluído!"