# Redefinir configurações de rede
Write-Host "`n[+] Redefinindo configurações de rede (Flush DNS, Reiniciar Winsock e IP)..."
try {
    ipconfig /flushdns
    Write-Host "    - Cache DNS limpo."

    netsh winsock reset
    Write-Host "    - Catálogo Winsock redefinido."

    netsh int ip reset
    Write-Host "    - Configurações IP redefinidas."

    Write-Host "✅ Redefinição de rede concluída (pode exigir reinicialização)."
} catch {
    Write-Host "❌ Erro ao redefinir configurações de rede: $($_.Exception.Message)"
}