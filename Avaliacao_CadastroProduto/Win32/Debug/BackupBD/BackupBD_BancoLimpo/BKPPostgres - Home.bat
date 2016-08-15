@ECHO OFF
set PGUSER=postgres  
set PGPASSWORD=Z?:3H3!G_4`n

for /f "tokens=1,2,3 delims=/ " %%i in ('DATE /T') do set datestr=%%k-%%j-%%i
    
echo "Aguarde, realizando o backup do Banco de Dados"
echo ---------------------------------------------------------------
"C:\Program Files (x86)\PostgreSQL\9.4\bin\pg_dump.exe" -i -h localhost -p 5432 -U postgres -F c -b -v -f "G:/Delphi/Trabalho_Infasstec/InfamatV5_SocialXE8-2015-10-09-16-47-17/InfamatV5_SocialXE8/Win32/Release/BackupBD/BackupBD_BancoLimpo/DBInfamat%datestr%.sql" infamatteste
echo ---------------------------------------------------------------
echo "Pronto!, backup realizado com Sucesso!"
@ECHO ON   

@ECHO OFF
set PGUSER=postgres  
set PGPASSWORD=Z?:3H3!G_4`n

for /f "tokens=1,2,3 delims=/ " %%i in ('DATE /T') do set datestr=%%k-%%j-%%i
    
echo "Aguarde, realizando o backup do Banco de Dados"
echo ---------------------------------------------------------------
"C:\Program Files (x86)\PostgreSQL\9.4\bin\pg_dump.exe" -i -h localhost -p 5432 -U postgres -F c -b -v -f "G:/Delphi/Trabalho_Infasstec/InfamatV5_SocialXE8-2015-10-09-16-47-17/InfamatV5_SocialXE8/Win32/Release/BackupBD/BackupBD_BancoLimpo/DBInfamat%datestr%.backup" infamatteste
echo ---------------------------------------------------------------
echo "Pronto!, backup realizado com Sucesso!"
@ECHO ON   
pause