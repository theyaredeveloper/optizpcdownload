@echo off
:: Script completo per l'ottimizzazione del computer
:: Autore: opt file system

echo =======================================
echo         Ottimizzazione del sistema
echo     AUTORI TOOL: OPT MANAGER VARIO
echo =======================================
echo.

:: Controlla se il file è eseguito come amministratore
whoami /groups | find "S-1-16-12288" >nul
if not %errorlevel%==0 (
    echo Per favore, esegui questo script come amministratore.
    pause
    exit
)

:: Pulizia dei file temporanei
echo Pulizia dei file temporanei in corso...
del /q /s %temp%\* >nul 2>&1
rd /s /q %temp% >nul 2>&1
md %temp%
echo File temporanei puliti.

:: Pulizia della cartella Prefetch
echo Pulizia della cartella Prefetch...
del /q /s C:\Windows\Prefetch\* >nul 2>&1
echo Prefetch pulito.

:: Svuotamento della cache DNS
echo Svuotamento della cache DNS...
ipconfig /flushdns
echo Cache DNS svuotata.

:: Controllo e riparazione dei file di sistema
echo Verifica e riparazione dei file di sistema in corso...
sfc /scannow
echo Verifica dei file completata.

:: Controllo del disco con CHKDSK
echo Controllo del disco rigido in corso...
chkdsk C: /f /r
echo Controllo del disco completato.

:: Deframmentazione del disco
echo Deframmentazione del disco rigido in corso...
defrag C: /U /V
echo Deframmentazione completata.

:: Pulizia della cache di Windows Update
echo Pulizia della cache di Windows Update...
net stop wuauserv >nul 2>&1
del /q /s %windir%\SoftwareDistribution\* >nul 2>&1
net start wuauserv >nul 2>&1
echo Cache di Windows Update pulita.

:: Aggiornamento delle politiche di gruppo
echo Aggiornamento delle politiche di gruppo in corso...
gpupdate /force
echo Politiche aggiornate.

:: Domanda per il riavvio del sistema
echo.
echo Vuoi avviare il PC per eseguire una pulizia ancora più completa?
set /p restart="Metti S se è Sì oppure N se è No: "

if /i "%restart%"=="S" (
    echo Il sistema si riavvierà tra pochi secondi...
    shutdown /r /t 5
) else (
    echo Hai scelto di non riavviare il sistema. Ottimizzazione completata!
)

echo.
echo =======================================
echo    Ottimizzazione completata con successo!
echo =======================================
pause
exit
