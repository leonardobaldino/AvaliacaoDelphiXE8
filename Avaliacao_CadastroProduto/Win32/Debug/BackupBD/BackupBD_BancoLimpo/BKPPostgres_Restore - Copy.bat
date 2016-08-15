@ECHO OFF
set PGUSER=postgres  
set PGPASSWORD=Z?:3H3!G_4`n

for /f "tokens=1,2,3 delims=/ " %%i in ('DATE /T') do set datestr=%%k-%%j-%%i

echo "Aguarde, restaurando o backup do Banco de Dados"
echo ---------------------------------------------------------------

"C:\Program Files (x86)\PostgreSQL\9.4\bin\pg_restore.exe" -i -h localhost -p 5432 -U postgres -d infamatsocial -v "D:/Repositorio/InfamatV5_SocialXE8/Win32/Release/BackupBD/BackupBD_BancoLimpo/DBInfamat2015-09-11.backup"
echo ---------------------------------------------------------------
echo "Pronto!, backup restaurado com Sucesso!"
@ECHO ON   
pause