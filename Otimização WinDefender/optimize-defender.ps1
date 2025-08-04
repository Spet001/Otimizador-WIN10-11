<#
.SYNOPSIS
    Otimiza as configurações do Windows Defender para reduzir o uso de recursos.

.DESCRIPTION
    Este script realiza as seguintes otimizações:
    1. Limita o uso de CPU do serviço Antimalware (MsMpEng.exe) via Registro.
    2. Modifica a tarefa agendada "Windows Defender Scheduled Scan"
       para ser executada apenas quando o computador estiver ocioso e
       interromper se o computador deixar de estar ocioso.

.NOTES
    - Executar como Administrador.
    - As configurações do Agendador de Tarefas podem ser revertidas pelo sistema
      em algumas instalações do Windows, caso haja mecanismos de proteção de integridade.
#>

# --- Parâmetros Configuráveis ---
$cpuLimitPercent = 10 # Limite de CPU para o Defender (em porcentagem, ex: 10 para 10%)
$idleStartMinutes = 15 # Iniciar a tarefa somente se o computador estiver ocioso há (em minutos)
$idleWaitHours = 1 # Aguardar para ficar ocioso por (em horas)

# --- Verificar se o script está sendo executado como Administrador ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Este script precisa ser executado como Administrador." -ForegroundColor Red
    Write-Host "Por favor, clique com o botão direito no arquivo .ps1 e selecione 'Executar como Administrador'." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    exit 1
}

Write-Host "Iniciando otimização do Windows Defender..." -ForegroundColor Green

# --- 1. Otimização do Uso de CPU via Registro ---
Write-Host "`n[1/2] Configurando limite de CPU para o Windows Defender..." -ForegroundColor Cyan

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Scan"
$propertyName = "AvgCPULoadFactor"

try {
    # Criar a chave 'Scan' se não existir
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Chave de Registro '$registryPath' criada." -ForegroundColor DarkYellow
    }

    # Definir o valor AvgCPULoadFactor
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $cpuLimitPercent -Force -ErrorAction Stop
    Write-Host "Limite de CPU para o Defender definido para $cpuLimitPercent%." -ForegroundColor Green
}
catch {
    Write-Host "Erro ao configurar o limite de CPU no Registro: $($_.Exception.Message)" -ForegroundColor Red
}

# --- 2. Otimização da Tarefa Agendada do Windows Defender ---
Write-Host "`n[2/2] Configurando a tarefa agendada 'Windows Defender Scheduled Scan'..." -ForegroundColor Cyan

$taskPath = "\Microsoft\Windows Defender\"
$taskName = "Windows Defender Scheduled Scan"

try {
    # Obter a tarefa agendada
    $task = Get-ScheduledTask -TaskPath $taskPath -TaskName $taskName -ErrorAction Stop

    # Converter minutos e horas para formato de duração (ISO 8601)
    $idleDuration = "PT$($idleStartMinutes)M" # Ex: PT15M para 15 minutos
    $idleWaitTimeout = "PT$($idleWaitHours)H" # Ex: PT1H para 1 hora

    # Modificar as configurações da tarefa
    # Aqui usamos Set-ScheduledTask com os parâmetros diretos
    Set-ScheduledTask -TaskName $taskName -TaskPath $taskPath `
        -Settings (Set-ScheduledTaskSetting -InputObject $task.Settings `
            -StartWhenIdle `
            -IdleDuration $idleDuration `
            -IdleWaitTimeout $idleWaitTimeout `
            -StopIfGoingOffIdle) `
        -ErrorAction Stop

    Write-Host "Tarefa '$taskName' configurada com sucesso:" -ForegroundColor Green
    Write-Host "  - Iniciar somente se ocioso há: $idleStartMinutes minutos" -ForegroundColor Green
    Write-Host "  - Aguardar para ficar ocioso por: $idleWaitHours hora(s)" -ForegroundColor Green
    Write-Host "  - Interromper se o computador deixar de estar ocioso: Ativado" -ForegroundColor Green

    # Remover outras condições se elas existirem e não forem a de ociosidade e energia.
    # Esta parte é mais complexa e arriscada de automatizar sem testar profundamente
    # em todos os cenários de Windows Defender. As configurações acima já são as mais importantes.
    # Para garantir que apenas as opções de ociosidade e energia estejam marcadas,
    # você pode precisar de uma manipulação mais granular dos triggers,
    # mas o Set-ScheduledTask com -Settings já sobrescreve muitas delas.
    # O foco aqui é garantir as condições de ociosidade e "stop if not idle".

}
catch {
    Write-Host "Erro ao configurar a tarefa agendada '$taskName': $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Verifique se você conseguiu modificar as opções manualmente anteriormente, ou se há permissões restritas." -ForegroundColor Yellow
}

Write-Host "`nProcesso de otimização concluído." -ForegroundColor Green
Write-Host "Reinicie o computador para garantir que todas as configurações entrem em vigor." -ForegroundColor Green

# Pause para que o usuário veja a saída
Read-Host "Pressione Enter para sair..."