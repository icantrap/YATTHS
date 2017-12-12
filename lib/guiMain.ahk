#NoEnv
#SingleInstance Force
#Include %A_ScriptDir%/lib/kLib.ahk

Main := new kGUI
Main.Create("MainGUI", 395, 580, "YATTHS")

Menu FileMenu, Add, Settings..., SettButton
Menu FileMenu, Add
Menu FileMenu, Add, Exit`tEsc, ExitButton
; Menu InfoMenu, Add, About, AboutButton
Menu MenuBar, Add, File, :FileMenu
; Menu MenuBar, Add, Info, :InfoMenu

Gui MainGUI: Menu, MenuBar
Gui MainGUI: Add, StatusBar, vStatusBar

bField1 := new SettingField
bField1.Init(Main)
bField1.ControlShift := -170
bField1.AddControl("Button", "StaButton", "gStartButton w105 h30", "Start")

Main.FieldCount -= 1

bField2 := new SettingField
bField2.Init(Main)
bField2.ControlShift := -35
bField2.AddControl("Button", "PButton", " gPauseButton w105 h30", "Pause")

Main.FieldCount -= 1

bField3 := new SettingField
bField3.Init(Main)
bField3.ControlShift := 100
bField3.AddControl("Button", "StoButton", "gStopButton w105 h30", "Stop")

Main.FieldCount += 0.5

rField := new SettingField
rField.Init(Main)
rField.AddField("rField", "vRoundsText", "0 Rounds")

logField := new SettingField
logField.Init(Main)
logField.ControlShift := -170
logField.AddControl("ListView", "Log", "x4 y62 w375 h480", "Log")

/*
Menu FileMenu, Add, Settings..., SettButton
Menu FileMenu, Add
Menu FileMenu, Add, Exit`tEsc, ExitButton
Menu InfoMenu, Add, About, AboutButton
Menu MenuBar, Add, File, :FileMenu
Menu MenuBar, Add, Info, :InfoMenu

Gui Main: New,, YATTHS
Gui Main: Menu, MenuBar
Gui Main: Add, Button, gStartButton x4 y3 w105 h30, &Start
Gui Main: Add, Button, gStopButton x253 y3 w105 h30, &Stop
Gui Main: Add, ListView, x4 y62 w353 h502, Log
Gui Main: Add, Text, vRoundsText x8 y39 w121 h16, 0 Rounds
Gui Main: Add, StatusBar, vStatusBar
Gui Main: Add, Button, vPButton gPauseButton x129 y3 w105 h30, &Pause
Gui Main: Show, w361 h592, YATTHS
*/
