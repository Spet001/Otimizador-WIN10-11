import tkinter as tk
from tkinter import messagebox
import subprocess
import os

def run_script(script_path):
    try:
        # Abre o script PowerShell com o PowerShell.exe
        # O "-File" é importante para executar o script como um arquivo
        process = subprocess.Popen(['powershell.exe', '-File', script_path], creationflags=subprocess.CREATE_NO_WINDOW)
        # Opcional: esperar o script terminar e capturar a saída
        # stdout, stderr = process.communicate()
        # if stdout:
        #     messagebox.showinfo("Saída do Script", stdout.decode())
        # if stderr:
        #     messagebox.showerror("Erro no Script", stderr.decode())
        
        messagebox.showinfo("Sucesso", f"Script '{os.path.basename(script_path)}' iniciado com sucesso!")
    except FileNotFoundError:
        messagebox.showerror("Erro", "PowerShell não encontrado. Certifique-se de que está instalado e no PATH.")
    except Exception as e:
        messagebox.showerror("Erro", f"Ocorreu um erro ao executar o script: {e}")

def create_gui():
    root = tk.Tk()
    root.title("Otimizador de PC")
    root.geometry("500x400")

    label = tk.Label(root, text="Escolha uma otimização para rodar:")
    label.pack(pady=10)

    # Botão para o script Otimização1.ps1
    btn_otimizacao1 = tk.Button(root, text="Otimizações Leves (SysMain, Compactação, Desligamento Rápido)", 
                                command=lambda: run_script("Otimização1.ps1"))
    btn_otimizacao1.pack(pady=5)

    # Botão para o script Otimização2.ps1
    btn_otimizacao2 = tk.Button(root, text="Desabilitar Tarefas do Edge", 
                                command=lambda: run_script("Otimização2.ps1"))
    btn_otimizacao2.pack(pady=5)

    
    # Botão para Limpeza de Temporários
    btn_limpeza_temp = tk.Button(root, text="Limpar Arquivos Temporários ", 
                                 command=lambda: run_script("Otimização_temp.ps1"))
    btn_limpeza_temp.pack(pady=5)

# Botão para Otimização3.ps1
    btn_otimizacao2 = tk.Button(root, text="Otimizações diversas", 
                                command=lambda: run_script("Otimização3.ps1"))
    btn_otimizacao2.pack(pady=5)

# Botão para desativar o Sysmain
    btn_otimizacao2 = tk.Button(root, text="Desabilitar Sysmain", 
                                command=lambda: run_script("sysmain.ps1"))
    btn_otimizacao2.pack(pady=5)

# Botão para Otmização de rede 1
    btn_otimizacao2 = tk.Button(root, text="Otimização de rede 1", 
                                command=lambda: run_script("OtimizaçãoRede1.ps1"))
    btn_otimizacao2.pack(pady=5)

# Botão para Otmização de rede 2
    btn_otimizacao2 = tk.Button(root, text="Otimização de rede 2", 
                                command=lambda: run_script("OtimizaçãoRede2.ps1"))
    btn_otimizacao2.pack(pady=5)

# Botão para Criar ponto de restauração
    btn_otimizacao2 = tk.Button(root, text="Criar ponto de restauração (recomendado)", 
                                command=lambda: run_script("restauração.ps1"))
    btn_otimizacao2.pack(pady=5)



    root.mainloop()

if __name__ == "__main__":
    create_gui()