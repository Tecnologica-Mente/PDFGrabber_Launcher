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
echo:             [2] To run PDFGrabber script
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
if not exist "Console-Launcher.exe" (
   echo Cannot find the Console-Launcher.exe file. Operation aborted
   goto :End
)
if exist "%mypath%\App\Python\Scripts\pip.exe" (
   if not exist "%mypath%\App\Python\Scripts\normalizer.exe" (
      REM The following line does not work with the Python Console
      REM START /wait "" Console-Launcher.exe "pip install -r requirements.txt"
      echo Please right click on the Console-Launcher and press Enter to start installation/update process
      echo|set/p="pip install -r requirements.txt"|clip
      START /wait "" Console-Launcher.exe %p%
      echo All the required dependencies has been installed/updated
   ) else (
      echo All the required dependencies has been already installed/updated
   )
) else (
   echo Cannot find the pip.exe file. Make sure Portable Python has been installed correctly
)
)
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
if exist "Console-Launcher.exe" if exist "download.py" (
   REM The following line does not work with the Python Console
   REM START /wait "" Console-Launcher.exe "python download.py"
   REM copy some text to the clipboard
   echo Please right click on the Console-Launcher and press Enter to start download process
   echo|set/p="python download.py"|clip
   START /wait "" Console-Launcher.exe
)
if not exist "Console-Launcher.exe" echo Cannot find the Console-Launcher.exe file. Operation aborted
if not exist "download.py" echo Cannot find the download.py file. Operation aborted
echo:
echo Press any key to continue...
pause >nul
popd
exit /b

::========================================================================================================================================
