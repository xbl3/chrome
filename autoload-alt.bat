@echo off
setlocal enabledelayedexpansion

rem notes at ~/60 -- bottom (dont know wtf winders does when hes drunk so escaping the tilde in comments smh)

set allIn=%*
if not defined allIn (
 call:netList
    ) else (
    call:localList
    )
    goto:eof


:tooConvoluted
:dur for %%i in (%*) do (if NOT "%%~i" == "" (set useNet=0))


:netList
set extensionList="https://raw.githubusercontent.com/xbl3/lists/master/chromeExtensions"
 for /f "useback delims=" %%i in (`curl --silent !extensionList!`) do (set extensionArray="%%~i" !extensionArray!)
call:getShinyChrome

    goto:eof


goto:eof
    :fuckOffWeGITinGood
:localList

set extensionList=%1
	if not defined extensionList (
echo:
echo Please enter the extension list to build array from
echo To use !allIn! just skip this shit by hitting enter
echo:
set /p extensionList="Path to list:	"
)
if not defined extensionList (set extensionsList=!allIn!)
:dequote._.Array
if defined extensionList (for /f "delims=" %%i in (!extensionList!) do (if exist %%~i set extensionList=%%~i))
if defined extensionList (for /f "usebackq delims=" %%i in (!extensionList!) do (set extensionArray="%%~i" !extensionArray!))



:getShinyChrome

set getChromeEXE=dir /b /s "C:\Program Files (x86)\Google"\*chrome.exe
set chromeCount=

for /f "usebackq delims=" %%i in (`%getChromeEXE%`) do (
set /a chromeCount+=1
set chrome!chromeCount!="%%~i"
)

for /L %%i in (1,1,!chromeCount!) do (
echo:[%%i] !chrome%%i!
set choiceArray=!choiceArray!%%i

)
choice /c !choiceArray! /m "please pick one" /t 13 /d 1
echo:!chrome%errorLevel%! -- !extensionArray!
set app=!chrome%errorLevel%!
set ext=!extensionArray!

!app! -- !ext!

goto:END






rem Get so fucking tired of pulling up extensions and all my accounts get so trashed so dont even bother syncing really
rem This is a ghetto bandaid - workaround whatever /\/\/ This just parses the extension list via curl instead of a local list
rem Either use this as it can do both - or - if local only use the regualr autoload too. 
rem Might kinda do like I did with the local part and make callable with url but doesnt make sense with net uri shit
rem Plug in a list below in top area or go through the local process -- actually maybe Ill have it toggle to local if it gets input
rem ill throw a toggle up top too who fucking know. doubt anyone will even see this shitty stuff


rem either way takes list - builds quoted array - launches whole array at once ----base pupose
rem again get tired of this shit so----
rem gets ALL installed chrome browsers - builds numbered list _ pick from selectable menu ------lazy pupose
rem iirc default is number 1 but can be changed to whatever - including timeout of 13 sec i think

:END
endlocal
goto:eof
