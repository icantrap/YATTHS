#NoEnv
#SingleInstance Force
#Include %A_ScriptDir%/lib/kLib.ahk

;
;
;   guiSettings module offloads implementation of the Settings GUI
;
;

Sett := new kGUI
Sett.Create("Settings", 369, 389, "YATTHS Settings")

Sett.Save := Func("saveSettingData")
Sett.Load := Func("loadSettingData")

gvField := new SettingField
gvField.Init(Sett)
gvField.AddField("gvText", "ym-1 0x200", "Game Version")
gvField.AddControl("ComboBox", "gvCombo", "w70 vGameVersion", "INTL||JP")

ssField := new SettingField
ssField.Init(Sett)
ssField.AddField("ssText", "ym-1 0x200", "Scroll Speed")
ssField.AddControl("Edit", "ssEdit", "w70 vScrollSpeed", "60")

vbField := new SettingField
vbField.Init(Sett)
vbField.ControlFloat := 5
vbField.AddControl("CheckBox", "vbBox", "vVerbose", "Verbose Logging")


; Heart Claiming Settings
Bar1 := new SettingField
Bar1.Init(Sett)
Bar1.AddField("Bar1", "", "")

field := new SettingField
field.Init(Sett)
field.AddField("hcText", "", "Heart Claiming")
field.AddControl("CheckBox", "hcCI", "vClaimInd", "Claim individually")

field := new SettingField
field.Init(Sett)
field.FieldShift := 110
field.ControlShift := 100
field.AddField("reclaimThresholdLabel", "0x200", "Reclaim Threshold")
field.AddControl("Edit", "reclaimThresholdEdit", "w70 vReclaimThreshold", "90")
SetHoverText(reclaimThresholdEdit, "Reopen mailbox and reclaim if more than this many claimed individually.")

field := new SettingField
field.Init(Sett)
field.AddControl("CheckBox", "hcBC", "vSkipBegin", "Skip beginning claim")

field := new SettingField
field.Init(Sett)
field.AddControl("CheckBox", "hcFC", "vSkipEnd", "Skip final claim")

Bar2 := new SettingField
Bar2.Init(Sett)
Bar2.AddField("Bar2", "", "")

hsField := new SettingField
hsField.Init(Sett)
hsField.AddField("hsText", "", "Heart Sending")
hsField.AddControl("CheckBox", "hsIg0", "vIgnore0", "Ignore 0 Score Players")

hsField2 := new SettingField
hsField2.Init(Sett)
hsField2.AddControl("CheckBox", "hsRiM", "vSendtoMail", "Send hearts to requests in mailbox")
SetHoverText(hsRiM, "Only works when claiming individually")

Bar3 := new SettingField
Bar3.Init(Sett)
Bar3.AddField("Bar3", "", "")

TimeField := new SettingField
TimeField.Init(Sett)
TimeField.AddField("tfText", "0x200", "Timings")

Sett.FieldCount -= 1

TimeField2 := new SettingField
TimeField2.Init(Sett)
TimeField2.FieldShift := 110
TimeField2.ControlShift := 100
TimeField2.AddField("tfMText", "0x200", "Minutes Between Rounds")
TimeField2.AddControl("Edit", "tfMEdit", "w70 vRoundMinutes", "5")

newField := new SettingField
newField.Init(Sett)
newField.FieldShift := 110
newField.ControlShift := 100
newField.AddField("tfTTCSText", "0x200", "Time to Click - Submit(ms)")
newField.AddControl("Edit", "tfTCCEdit", "w70 vTTCS", "200")
SetHoverText(tfTTCSText, "Only functions on parts of the script that submit an action")

newField := new SettingField
newField.Init(Sett)
newField.FieldShift := 110
newField.ControlShift := 100
newField.AddField("tfTTCCText", "0x200", "Time to Click - Confirmation(ms)")
newField.AddControl("Edit", "tfTCCEdit", "w70 vTTCC", "200")
SetHoverText(tfTTCCText, "Only functions on parts of the script that react to a confirmation")

TimeField5 := new SettingField
TimeField5.Init(Sett)
TimeField5.FieldShift := 110
TimeField5.ControlShift := 100
TimeField5.AddField("tfSDText", "0x200", "Scroll Delay (ms)")
TimeField5.AddControl("Edit", "tfSDEdit", "w70 vScrollDelay", "5")

ConfirmField := new SettingField
ConfirmField.Init(Sett)
ConfirmField.ControlShift := -40
ConfirmField.ControlFloat := 10
ConfirmField.AddControl("Button", "cfButton", "gSettOK w80", "OK")

GHeight := 25 + (Sett.FieldCount * 24)

Sett.ResizeGUI(Sett.Width, GHeight)

saveSettingData(this)
{
    Global
    local myName

    myName := this.name
    Gui, %myName%:Submit

    IniWrite %Verbose%, YATTHS.ini, Settings, Verbose
    IniWrite %TTCS%, YATTHS.ini, Settings, TTCS
    IniWrite %TTCC%, YATTHS.ini, Settings, TTCC
    IniWrite %ScrollDelay%, YATTHS.ini, Settings, ScrollDelay
    IniWrite %ScrollSpeed%, YATTHS.ini, Settings, ScrollSpeed
    IniWrite %ClaimInd%, YATTHS.ini, Settings, ClaimIndividually
    IniWrite %ReclaimThreshold%, YATTHS.ini, Settings, ReclaimThreshold
    IniWrite %RoundMinutes%, YATTHS.ini, Settings, RoundTime
    IniWrite %GameVersion%, YATTHS.ini, Settings, GameVersion
    IniWrite %Ignore0%, YATTHS.ini, Settings, Ignore0
    IniWrite %SkipBegin%, YATTHS.ini, Settings, SkipBegin
    IniWrite %SkipEnd%, YATTHS.ini, Settings, SkipEnd
    IniWrite %SendtoMail%, YATTHS.ini, Settings, SendtoMail
}

loadSettingData(this)
{
    Global
    local myName

    myName := this.name

    IniRead VerboseValue, YATTHS.ini, Settings, Verbose, 0
    IniRead TTCSValue, YATTHS.ini, Settings, TTCS, 200
    IniRead TTCCValue, YATTHS.ini, Settings, TTCC, 200
    IniRead ScrollDelayValue, YATTHS.ini, Settings, ScrollDelay, 1000
    IniRead ScrollSpeedValue, YATTHS.ini, Settings, ScrollSpeed, 60
    IniRead ClaimIndValue, YATTHS.ini, Settings, ClaimIndividually, 0
    IniRead ReclaimThresholdValue, YATTHS.ini, Settings, ReclaimThreshold, 90
    IniRead RoundMinutesValue, YATTHS.ini, Settings, RoundTime, 5
    IniRead GameVersionValue, YATTHS.ini, Settings, GameVersion, INTL
    IniRead Ignore0Value, YATTHS.ini, Settings, Ignore0, 0
    IniRead SkipBeginValue, YATTHS.ini, Settings, SkipBegin, 0
    IniRead SkipEndValue, YATTHS.ini, Settings, SkipEnd, 0
    IniRead SendtoMailValue, YATTHS.ini, Settings, SendtoMail, 0

    GuiControl,%myName%:,Verbose, %VerboseValue%
    GuiControl,%myName%:,TTCS, %TTCSValue%
    GuiControl,%myName%:,TTCC, %TTCCValue%
    GuiControl,%myName%:,ScrollDelay, %ScrollDelayValue%
    GuiControl,%myName%:,ScrollSpeed, %ScrollSpeedValue%
    GuiControl,%myName%:, ClaimInd, %ClaimIndValue%
    GuiControl,%myName%:, ReclaimThreshold, %ReclaimThresholdValue%
    GuiControl,%myName%:, RoundMinutes, %RoundMinutesValue%
    GuiControl,%myName%:ChooseString, GameVersion, %GameVersionValue%
    GuiControl,%myName%:, Ignore0, %Ignore0Value%
    GuiControl,%myName%:, SkipBegin, %SkipBeginValue%
    GuiControl,%myName%:, SkipEnd, %SkipEndValue%
    GuiControl,%myName%:, SendtoMail, %SendtoMailValue%

    Gui, %myName%:Submit
}
