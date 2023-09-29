@echo off
setlocal EnableDelayedExpansion

rem ----------SET SID AND KEY CONTAINER-----------
set SID=S-1-5-21-lolololo-lo-ho-ho-ho-he-he-he-hey
set CONTAINER=my_key
rem ----------------------------------------------




for %%a in (*) do (
set input_file=%%a
if "!input_file:~-4!" == ".key" (
set output_file=!input_file:~,-4!.HEX
C:\Windows\system32\certutil -encodehex -f "!input_file!" "!output_file!" 12
)
)

echo Windows Registry Editor Version 5.00>output.reg
echo. >>output.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Crypto Pro\Settings\Users\!SID!\Keys\!CONTAINER!]>>output.reg

for %%b in (*) do (
set input_file=%%b
if "!input_file:~-4!" == ".HEX" (
echo !input_file!
set /p Hex=<!input_file!
call :Separator Hex
echo "!input_file!"=hex:!Hex!
echo "!input_file:~,-4!.key"=hex:!Hex!>>output.reg
echo -
)
)


for %%c in (*) do (
set file=%%c
if "!file:~-4!" == ".HEX" (del /s /q !file!)
)

endlocal
exit /b

:Separator
set string=!%1!#
set pos=0
:startLoop
call set chr=%%string:~%pos%,2%%
if !chr!==# goto End
set HexRebuild=!HexRebuild!!chr!,
set /a pos+=2
goto startLoop

:End
set HexRebuild=!HexRebuild:~0,-1!
set "%1=%HexRebuild%"
rem echo OUTPUT = !Hex!




