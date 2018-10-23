@echo off

title EUWIN launcher beta

:mainMenu
cls
echo.
echo MOD ACTIVADO EUWIN
echo.
echo 1 - JUGAR
echo 2 - OPCIONES
echo 3 - CREDITOS
echo 9 - SALIR
echo.
set /p mainMenuChoose= "Elige una opcion. [%mainMenuChoose%]: "
if %mainMenuChoose%==1 start EUWIN.bat & exit
if %mainMenuChoose%==2 goto options
if %mainMenuChoose%==3 start https://goo.gl/w7babp & goto mainMenu
if %mainMenuChoose%==9 exit
echo.
echo. OPCION INCORRECTA!
echo.
pause
goto mainMenu

:options
cls
echo.
echo OPCIONES
echo.
echo 1 - INICIO AVANZADO
echo 2 - CONFIGURAR BOTS (Bots: %botcount%, Habilidad: %botskill%)
echo 3 - INICIAR SERVIDOR DEDICADO
echo 4 - INICIAR SERVIDOR CON DEPURADOR (necesita bf2editor)
echo 5 - INICIAR EDITOR
echo 6 - Seleccionar lenguaje (wip)
echo 9 - VOLVER
rem opcion de guardar cambios
echo.
set /p optionsChoose="Elige una opcion. [%optionsChoose%]: "
if %optionsChoose%==1 call inicioAvanzado.bat & goto options
if %optionsChoose%==2 goto botsConfig
if %optionsChoose%==3 goto startServer
if %optionsChoose%==4 goto startDebugServer
if %optionsChoose%==5 goto bf2editor
if %optionsChoose%==6 goto language
if %optionsChoose%==7 goto killBf2
if %optionsChoose%==9 goto mainMenu
echo.
echo. OPCION INCORRECTA!
echo.
pause
goto options

:botsConfig
cd AI
cls
echo CAMBIAR CANTIDAD DE BOTS
echo.
echo Introduce la cantidad de robots sin contar jugadores humanos.
set /p botCount="Establecer numero de bots: "
if %botCount% GTR 256 goto botsConfig
:botSkillConfig
cls
echo CAMBIAR NIVEL DE HABILIDAD DE LOS BOTS
echo.
echo El nivel maximo es 1. Nivel minimo es 0.1
set /p botskill="Establecer habilidad para los bots: "
if %botskill% GTR 1 goto botSkillConfig

del AIDefault.ai
echo rem Archivo generado por %USERNAME% >> aidefault.ai
echo aiSettings.setNSides 2 >> aidefault.ai
echo aiSettings.setAutoSpawnBots 1 >> aidefault.ai
echo. >> AIDefault.ai
echo aiSettings.overrideMenuSettings 1 >> aidefault.ai
echo aiSettings.setMaxNBots %botcount% >> aidefault.ai
echo aiSettings.maxBotsIncludeHumans 0 >> aidefault.ai
echo aiSettings.setBotSkill %botskill% >> aidefault.ai
echo. >> aidefault.ai
echo run BotNames.ai >> aidefault.ai
echo. >> aidefault.ai
echo aiSettings.setInformationGridDimension 32 >> aidefault.ai
echo. >> aidefault.ai
echo run AIPathFinding.ai >> aidefault.ai
echo. >> aidefault.ai
echo rem EOF >> aidefault.ai
pause
goto options

:startServer
cls
echo Ejecutando servidor... No cierres esta ventana antes de finalizar servidor
:: [config]

set modName=EUWINPRO

:: [source]

title BF2 server

if exist "%userprofile%\documents\battlefield 2\ServerConfigs\_serverSettings.con" (goto:preLoad) else (goto:copyConfig)

:copyConfig
xcopy settings\ServerConfigs "%userprofile%\documents\battlefield 2\ServerConfigs\"
:preLoad
:: disableClientConfig
rem rename settings\ServerConfigs\_serverSettings.con _serverSettings.bak
rem rename settings\ServerConfigs\_maplist.con _maplist.bak
:: runServer
start /d ..\..\ /high Bf2_w32ded.exe +config "@HOME@/ServerConfigs/_serverSettings.con" +mapList "@HOME@/ServerConfigs/_maplist.con" +modPath mods/%modName% +ignoreAsserts 1 +dedicated 1 +multi 1
:checkRunServer
tasklist /fi "imagename eq bf2_w32ded.exe" |find ":" > nul
if errorlevel 1 goto:checkRunServer
:: restoreClientConfig
rem rename settings\ServerConfigs\_serverSettings.bak _serverSettings.con
rem rename settings\ServerConfigs\_maplist.bak _maplist.con
goto options

:startDebugServer
cls
echo Ejecutando servidor con depurador... No cierres esta ventana antes de finalizar servidor
:: [config]
set modName=EUWINPRO
:: [source]
start /d ..\..\ /high bf2_r.exe +config "@HOME@/ServerConfigs/_serverSettings.con" +mapList "@HOME@/ServerConfigs/_maplist.con" +modPath mods/%modName% +ignoreAsserts 1 +dedicated 1 +multi 1
goto mainMenu

:bf2editor
:: [config]
cls
set modName=%modName%
:listMods
cls
echo Lista de mods
echo.
cd ..\..\mods
SET count=1
FOR /f "tokens=*" %%G IN ('dir /b') DO (
call:subroutine %%G)
goto:ModChoose

:subroutine
set modName%count%=%1
echo %count% - %1
set /a count+=1
goto:eof

:ModChoose
echo Mod actual: %modName%
set /p modChoose="Elige una opcion: "

if %modChoose%==1 set modName=%modName1% & goto:eof
if %modChoose%==2 set modName=%modName2% & goto:eof
if %modChoose%==3 set modName=%modName3% & goto:eof
if %modChoose%==4 set modName=%modName4% & goto:eof
if %modChoose%==5 set modName=%modName5% & goto:eof
if %modChoose%==6 set modName=%modName6% & goto:eof
if %modChoose%==7 set modName=%modName7% & goto:eof
if %modChoose%==8 set modName=%modName8% & goto:eof
if %modChoose%==9 set modName=%modName9% & goto:eof
if %modChoose%==10 set modName=%modName10% & goto:eof
if %modChoose%==11 set modName=%modName11% & goto:eof
if %modChoose%==12 set modName=%modName12% & goto:eof
if %modChoose%==13 set modName=%modName13% & goto:eof
if %modChoose%==14 set modName=%modName14% & goto:eof
if %modChoose%==15 set modName=%modName15% & goto:eof


echo.
set loadLevel=Dalian_Plant

:startMod
start /d ..\..\ bf2editor.exe +loadMod %modName%
+loadLevel %loadLevel% +forceLoadPlugin SinglePlayerEditor

goto:mainMenu
	
:startEuwinWindow
	cls
	:resolutionMenu
	echo Elige la resolucion que prefieras para jugar en modo ventana
	echo.
	echo 1 - 1600 x 900
	echo 2 - 1280 x 720
	echo 3 - 1024 x 576
	echo 9 - Salir
	echo.

	set /p rChoice="Elige una opcion: "

	if %rChoice%==1 goto resolution1
	if %rChoice%==2 goto resolution2
	if %rChoice%==3 goto resolution3
	if %rChoice%==9 goto Salir

	echo.
	echo. ERROR: opcion incorrecta. Pulsa el numero indicado en el menu
	echo.
	pause
	goto Menu

	:resolution1
		set width=2560
		set height=1080
	goto:startMod

	:resolution2
		set width=1280
		set height=720
	goto:startMod

	:resolution3
		set width=1024
		set height=576
	goto:startMod

	:Salir
	Exit

	:startMod
	start /d ..\..\ bf2.exe +modPath mods/euwinpro +fullscreen 0 +szx %width% +szy %height%
	exit


:language
echo wip

setlocal enableextensions disabledelayedexpansion

set search=euwin
set replace=angel

set "textFile=test.txt"

for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
	set "line=%%i"
	setlocal enabledelayedexpansion
	>>"%textFile%" echo(!line:%search%=%replace%!
	endlocal
    )
goto:options

:killBf2
	taskkill /f /im bf2.exe

