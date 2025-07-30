# Lista as tarefas do Edge para confirmar
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Edge*" } | Format-Table TaskName, State

# Desabilita as tarefas relacionadas ao Edge
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Edge*" } | ForEach-Object {
    Disable-ScheduledTask -TaskName $_.TaskName
}

# Verifica se ficaram desabilitadas
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Edge*" } | Format-Table TaskName, State
