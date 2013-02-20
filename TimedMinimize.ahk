#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
CoordMode, Mouse, Screen

MaraschinoActive = 1
Menu, TRAY, NoStandard
Menu, TRAY, Add, Show Maraschino on Idle, MaraschinoToggle
Menu, TRAY, Check, Show Maraschino on Idle
Menu, TRAY, Add
Menu, TRAY, Standard
SetTimer, ShowDesktop, 10000
 Return

MaraschinoToggle:
	if (MaraschinoActive = 1)
	{
		MaraschinoActive = 0
		Menu, TRAY, Uncheck, Show Maraschino on Idle
	}
	else
	{
		MaraschinoActive = 1
		Menu, TRAY, Check, Show Maraschino on Idle
	}
	Return
 
ShowDesktop:
	if (A_TimeIdle > 20000)
	{	
		SetTimer, ShowDesktop, Off
		WinMinimizeAll
		SetTimer, RestoreWindows, 250
		if (MaraschinoActive = 1)
		{
			IfWinNotExist, http://192.168.0.105:7000
			  Run, "C:\Program Files\Internet Explorer\iexplore.exe" -k http://192.168.0.105:7000
		}
	}
	Return
	
RestoreWindows:
	if (A_TimeIdle < 10000)
	{
		SetTimer, RestoreWindows, Off
		Sleep, 250
		MouseGetPos, MouseX
		if (MouseX < 0)
		{
			Sleep, 2500
			IfWinActive, http://192.168.0.105:7000
			{
				WinSet, AlwaysOnTop, On, A
				WinMinimizeAllUndo
				Sleep 300
				WinSet, AlwaysOnTop, Off, A
				SetTimer, ShowDesktop, On
				Exit
			}
		}	
		WinClose, http://192.168.0.105:7000
		WinMinimizeAllUndo
		SetTimer, ShowDesktop, On
	}
	Return
	