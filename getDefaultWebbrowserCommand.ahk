#Requires AutoHotkey v2.0.0+
;==============================================================
; GetDefaultWebBrowserCommand — Retrieve the default web browser command template
;
; GitHub: https://github.com/SevenKeyboard/get-default-web-browser-command
; Author: SevenKeyboard Ltd. (2025)
; License: The Unlicense
;
; Documentation / References:
;   Firefox Front-end / Command Line Parameters
;     https://firefox-source-docs.mozilla.org/browser/CommandLineParameters.html
;==============================================================

;  '"C:\Program Files\Google\Chrome\Application\chrome.exe" --single-argument %1'
;  '"C:\Program Files\Google\Chrome\Application\chrome.exe" --single-argument ' verb

/*
    Blink--------------------------
Google Chrome           "C:\Program Files\Google\Chrome\Application\chrome.exe" --single-argument %1
Microsoft Edge          "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --single-argument %1
Vivaldi                 "C:\Users\%USERNAME%\AppData\Local\Vivaldi\Application\vivaldi.exe" --single-argument %1
    Gecko--------------------------
Firefox                 "C:\Program Files\Mozilla Firefox\firefox.exe" -osint -url "%1"
*/

class VersionManager_getDefaultWebBrowserCommand
{
    static _ := this._init()
    static _init()    {
        global
        GETDEFAULTWEBBROWSERCOMMAND_VERSION := "1.0.0"
    }
}
getDefaultWebBrowserCommand(verb?)    {
    try  {
        browserKeyName:=regRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice", "ProgId")
    }  catch  {
        return
    }
    try  {
        browserFullCommand:=regRead("HKEY_CLASSES_ROOT\" browserKeyName "\shell\open\command")
    }  catch  {
    }  else  {
        return (!isSet(verb)?browserFullCommand:regExReplace(browserFullCommand,"%1",verb))
    }
}