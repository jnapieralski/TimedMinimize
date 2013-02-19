#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

SetTimer, ShowDesktop, 10000
 Return

ShowDesktop:
	if (A_TimeIdle > 180000)
	{	
		SetTimer, ShowDesktop, Off
		WinMinimizeAll
		SetTimer, RestoreWindows, 500
	}
	Return

RestoreWindows:
	if (A_TimeIdle < 60000)
	{
		SetTimer, RestoreWindows, Off
		WinMinimizeAllUndo
		SetTimer, ShowDesktop, On
	}
	Return
	