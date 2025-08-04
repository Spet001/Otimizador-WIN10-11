# 🛡️ Otimizador do Windows Defender

Este script PowerShell otimiza as configurações do Windows Defender para reduzir o uso de recursos do sistema, mantendo a segurança. Ele limita o consumo de CPU do serviço Antimalware (`MsMpEng.exe`) e ajusta a tarefa agendada de verificação para rodar apenas quando o computador estiver ocioso. Incluí este separadamente pois é uma otimização mais "intrusiva".

## 🚀 Funcionalidades

- ✅ **Limitação de CPU**: Define um limite de uso de CPU para o Windows Defender (padrão: 10%) via Registro.
- ✅ **Otimização da Tarefa Agendada**: Configura a tarefa "Windows Defender Scheduled Scan" para:
  - Iniciar apenas quando o computador estiver ocioso por um período configurável (padrão: 15 minutos).
  - Interromper a verificação se o computador deixar de estar ocioso.
  - Aguardar até 1 hora para o computador ficar ocioso antes de iniciar a verificação.
- 🔧 Modifica apenas configurações seguras, mantendo a funcionalidade do Windows Defender.
- 🛡️ Inclui verificações de erro para garantir que as alterações sejam aplicadas corretamente.

## 🖥️ Requisitos

- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Disponível por padrão no Windows 10 e 11.
- **Permissões**: O script deve ser executado como administrador.
- **Windows Defender**: Deve estar ativo (o script não desativa a proteção).

## 📋 Instruções de Uso

1. **Baixe o Script**:
   - Faça o download do arquivo `Optimize-WindowsDefender.ps1` deste repositório.

2. **Crie um Ponto de Restauração (Recomendado)**:
   - Antes de executar o script, crie um ponto de restauração para proteger seu sistema contra alterações indesejadas.
   - Use nossa ferramenta **Otimizador-WIN10-11** para criar um ponto de restauração facilmente: [Otimizador-WIN10-11 no GitHub](https://github.com/Spet001/Otimizador-WIN10-11).

3. **Execute o Script como Administrador**:
   - Abra o PowerShell como administrador:
     - Pressione `Win + S`, digite "PowerShell", clique com o botão direito em "Windows PowerShell" e selecione **"Executar como administrador"**.
   - Navegue até o diretório onde o script está salvo. Por exemplo:
     ```powershell
     cd "C:\Caminho\Para\Seu\Diretório"
     ```
   - Execute o script:
     ```powershell
     .\Optimize-WindowsDefender.ps1
     ```
   - O script será executado automaticamente e exibirá mensagens sobre o progresso.

4. **Verifique o Resultado**:
   - Após a execução, as configurações do Windows Defender serão ajustadas para reduzir o impacto nos recursos do sistema.
   - Reinicie o computador para garantir que todas as alterações entrem em vigor.
   - Para verificar as alterações manualmente:
     - **Limite de CPU**: Abra o Editor de Registro (`regedit`) e navegue até:
       ```
       HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan
       ```
       Confirme que a propriedade `AvgCPULoadFactor` está definida como `10` (ou o valor configurado).
     - **Tarefa Agendada**: Abra o Agendador de Tarefas (`taskschd.msc`), navegue até `\Microsoft\Windows Defender\Windows Defender Scheduled Scan` e verifique se as condições de ociosidade estão configuradas (iniciar após 15 minutos de ociosidade, parar se não estiver ocioso).

## 🚨 Notas Importantes

- ⚠️ **Execute como Administrador**: O script precisa de permissões elevadas para modificar o Registro e o Agendador de Tarefas do Windows.
- 💡 **Crie um Ponto de Restauração**: Antes de aplicar qualquer alteração, use a ferramenta [Otimizador-WIN10-11](https://github.com/Spet001/Otimizador-WIN10-11) para criar um ponto de restauração. Isso permite reverter alterações, se necessário.
- 🧪 **Falsos Positivos de Antivírus**: Alguns antivírus podem sinalizar o script ou um executável gerado (se convertido com ferramentas como PyInstaller) como suspeito. Isso é comum e geralmente inofensivo, desde que o código-fonte seja confiável. Verifique o código antes de executar.
- 📚 **Entenda as Alterações**: O script modifica configurações do Windows Defender para otimizar o desempenho. Apesar de serem alterações seguras, os efeitos podem variar dependendo do sistema. Revise as mudanças no Registro e no Agendador de Tarefas, se desejar.
- 🔄 **Possível Reversão pelo Sistema**: Em algumas instalações do Windows, as configurações do Agendador de Tarefas podem ser revertidas por mecanismos de proteção de integridade do sistema. Verifique periodicamente se as configurações persistem.

## ⚖️ Isenção de Responsabilidade

Este software é fornecido "no estado em que se encontra", sem garantias expressas ou implícitas. O autor não se responsabiliza por quaisquer danos ou problemas que possam surgir do uso deste script. Use por sua conta e risco.

## 📧 Contato / Créditos

- **Autor**: Spet001
- **Licença**: MIT
- **Repositório**: [GitHub - Spet001/Otimizador-WIN10-11](https://github.com/Spet001/Otimizador-WIN10-11) (para backup/restauração/otimização)

## 🛠️ Solução de Problemas

- **Erro: "Este script precisa ser executado como Administrador"**:
  - Certifique-se de executar o PowerShell como administrador. Clique com o botão direito no arquivo `.ps1` e selecione "Executar como Administrador".
- **Erro: "Erro ao configurar a tarefa agendada"**:
  - Verifique se a tarefa `Windows Defender Scheduled Scan` existe no Agendador de Tarefas (`\Microsoft\Windows Defender\`).
  - Confirme que você tem permissões para modificar tarefas agendadas. Algumas instalações do Windows podem restringir alterações.
- **As configurações não persistem após reiniciar**:
  - Algumas versões do Windows podem reverter alterações no Agendador de Tarefas devido a mecanismos de proteção. Tente desativar temporariamente o Windows Defender ou verifique as políticas de grupo aplicadas.
- **Verificação Manual**:
  - **Registro**: Use o Editor de Registro (`regedit`) para verificar a chave:
    ```
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan
    ```
    Confirme que `AvgCPULoadFactor` está definido como `10`.
  - **Agendador de Tarefas**: Abra o Agendador de Tarefas (`taskschd.msc`), localize a tarefa `Windows Defender Scheduled Scan` e verifique as condições de ociosidade.

## 🗑️ Como Reverter as Alterações

Para reverter as alterações manualmente:
1. **Remover o Limite de CPU**:
   - Abra o Editor de Registro (`regedit`).
   - Navegue até:
     ```
     HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan
     ```
   - Exclua a propriedade `AvgCPULoadFactor` ou a chave `Scan`, se não for mais necessária.
2. **Restaurar a Tarefa Agendada**:
   - Abra o Agendador de Tarefas (`taskschd.msc`).
   - Localize `\Microsoft\Windows Defender\Windows Defender Scheduled Scan`.
   - Redefina as configurações padrão ou restaure o sistema usando o ponto de restauração criado com [Otimizador-WIN10-11](https://github.com/Spet001/Otimizador-WIN10-11).