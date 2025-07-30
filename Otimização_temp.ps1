# Limpa arquivos e pastas dentro de %TEMP%
Write-Host "[+] Limpando arquivos temporários..."
try {
    Get-ChildItem -Path $env:TEMP -Recurse -Force | Remove-Item -Recurse -Force
    Write-Host "✅ Arquivos temporários limpos com sucesso!"
} catch {
    Write-Host "❌ Erro ao limpar arquivos temporários: $($_.Exception.Message)"
}