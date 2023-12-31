@setlocal DisableDelayedExpansion
@echo off


::===========================================================================================================
::
::   This script is a PDFGrabber Launcher to download PDFs (and covers) from different services.
::
::   Homepage: https://github.com/Tecnologica-Mente
::      Email: <not available>
::
::   ********************************************************************************************************
::
::   Born from an idea of ​​Francesco (FelixFrog)
::
::===========================================================================================================




::========================================================================================================================================
:MainMenu

cls
color 07
title  PDFGrabber Launcher v1.0.0
mode 100, 30
set "pdfgltemp=%SystemRoot%\Temp\__PDFGL"
if exist "%pdfgltemp%\.*" rmdir /s /q "%pdfgltemp%\" %nul%

echo:
echo:
echo:             Welcome to PDFGrabber Launcher v1.0.0
echo:
echo:       _______________________________________________________________________________________
echo:
echo:             Please select:
echo:
echo:             [1] To install/upgrade all the required dependencies
echo:             [2] To run PDFGrabber
echo:             ___________________________________________________________________________
echo:                                                                     
echo:             [3] Read Me
echo:             [4] Exit
echo:       _______________________________________________________________________________________
echo:
echo:             Enter a menu option in the Keyboard [1,2,3,4]:
echo:
choice /C:1234 /N
set _erl=%errorlevel%

if %_erl%==4 exit /b
if %_erl%==3 start https://github.com/Tecnologica-Mente/PDFGrabber_Launcher 	& goto :MainMenu
if %_erl%==2 setlocal & call :DownloadPDF       & cls & endlocal 		& goto :MainMenu
if %_erl%==1 setlocal & call :IUDependencies    & cls & endlocal 		& goto :MainMenu
goto :MainMenu

::========================================================================================================================================
:IUDependencies
@setlocal DisableDelayedExpansion
@echo off

set mypath=%cd%
::@echo %mypath%

echo Installing/Updating Python's dependencies... Wait for it to finish...
if not exist "requirements.txt" (
   echo Cannot find the requirements.txt file. Operation aborted
   goto :End
)
start cmd.exe /k "pip install -r requirements.txt"
:End
echo:
echo Press any key to continue...
pause >nul
popd
exit /b

::========================================================================================================================================
:DownloadPDF
@setlocal DisableDelayedExpansion
@echo off

:: Adapted from: https://stackhowto.com/batch-file-to-check-if-multiple-files-exist/
set mypath=%cd%
::@echo %mypath%
if exist "main.py" (
   start cmd.exe /k "py main.py"
)
if not exist "main.py" echo Cannot find the main.py file. Operation aborted
echo:
echo Press any key to continue...
pause >nul
popd
exit /b

::========================================================================================================================================
