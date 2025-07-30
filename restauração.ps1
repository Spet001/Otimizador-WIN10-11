# Criar Ponto de Restauração
Write-Host "`n[+] Criando Ponto de Restauração do Sistema..."
try {
    # Habilitar a proteção do sistema na unidade C: se não estiver habilitada
    # Esta etapa é importante porque a criação de pontos de restauração falha se a proteção estiver desabilitada.
    $drive = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='C:'"
    if ($drive.SystemProtectionEnabled -ne $true) {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction Stop
        Write-Host "    - Proteção do sistema habilitada para a unidade C:."
    }

    # Criar o ponto de restauração
    Checkpoint-Computer -Description "Ponto de Restauração antes das Otimizações do PC" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    Write-Host "✅ Ponto de Restauração criado com sucesso!"
} catch {
    Write-Host "❌ Erro ao criar Ponto de Restauração: $($_.Exception.Message)"
}