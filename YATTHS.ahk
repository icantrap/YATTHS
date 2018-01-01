;
;   YATTHS - Yet Another TsumTsum Heart Sender
;       Version 0.9
;

#NoEnv
#SingleInstance Force
#Include %A_ScriptDir%/lib/guiSettings.ahk
#Include %A_ScriptDir%/lib/guiMain.ahk

SetWorkingDir %A_ScriptDir%
SendMode Input
DetectHiddenWindows, On

Main.ShowGUI()

; Gui About: New,, About
;
; Gui About: Add, Text, vTool_Version x9 y157 w461 h25 +0x200 Center
; Gui About: Add, Button, gAboutOK x199 y182 w80 h23, &OK
; Gui About: Add, Text, x13 y132 w458 h23 +0x200, nething4tc for the inspiration and foundation to make this tool
; Gui About: Font, s10
; Gui About: Add, Text, x12 y117 w120 h23 +0x200, Credit:
; Gui About: Font
; Gui About: Font, s14
; Gui About: Add, Text, x2 y1 w476 h32 +0x200 Center, TsumTsum Advanced Heart Sending
; Gui About: Font
; Gui About: Add, Text, x1 y27 w476 h18 +0x200 Center, by RinArenna
; Gui About: Add, Text, x8 y57 w465 h43, I am excited to be part of the TsumTsum community and provide this tool, which will always be a free tool to use and download. I want to thank all members of the Reddit community for their support and help in finding and solving issues in the tool. Without your help, this tool wouldn't work!


GoSub, Instantiate
Return

MenuHandler:
Return

MainGUIGuiEscape:
MainGUIGuiClose:
    ExitApp

; Do not edit above this line

SettOK:
    Sett.Save()

    if (Verbose)
    {
        AddLog("ClaimInd: " ClaimInd)
        AddLog("RoundMinutes: " RoundMinutes)
    }

    GUI Settings: Hide
    return

AboutOK:
    Gui About: Hide
    return

SettButton:
    Sett.ShowGUI()
    return

AboutButton:
    Gui About: Show, w481 h213
    return

ExitButton:
    ExitApp

Instantiate:
    RoundsText := 0
    GuiControl,About:,Tool_Version, YATTHS 0.9
    SetWorkingDir %A_ScriptDir%
    n_Width := 0
    n_Height := 0
    ControlGetPos, n_X, n_Y, n_Width, n_Height, subWin1, Nox ahk_class Qt5QWindowIcon


    ClickPoint(200,60)
    WinActivate, Nox ahk_Class QtQ5WindowIcon
    WinGetPos win_X, win_Y, win_Width, win_Height, A ;NoxPlayer
    WinGetActiveStats nw_Title, nw_Width, nw_Height, nw_X, nw_Y

    AddLog(nw_Title " Size: " n_Width "x" n_Height)

    Sett.Load()

    if (Verbose)
    {
        AddLog(win_X ", " win_Y ", " win_Width ", " win_Height)
    }

    ResetL = 0
    Rounds = 0
    GuiControl,, RoundsText, %Rounds% rounds


    /*
    Gui, Settings:Default

    IniRead ScrollSpeedValue, YATTHS.ini, Settings, ScrollSpeed, 60
    IniRead ClaimIndValue, YATTHS.ini, Settings, ClaimIndividually, 0
    IniRead RoundMinutesValue, YATTHS.ini, Settings, RoundTime, 5
    IniRead GameVersionValue, YATTHS.ini, Settings, GameVersion, INTL
    IniRead Ignore0Value, YATTHS.ini, Settings, Ignore0, 0
    IniRead SkipBeginValue, YATTHS.ini, Settings, SkipBegin, 0
    IniRead SkipEndValue, YATTHS.ini, Settings, SkipEnd, 0
    IniRead SendtoMailValue, YATTHS.ini, Settings, SendtoMail, 0

    GuiControl,,ScrollSpeed, %ScrollSpeedValue%
    GuiControl,, ClaimInd, %ClaimIndValue%
    GuiControl,, RoundMinutes, %RoundMinutesValue%
    GuiControl, ChooseString, GameVersion, %GameVersionValue%
    GuiControl,, Ignore0, %Ignore0Value%
    GuiControl,, SkipBegin, %SkipBeginValue%
    GuiControl,, SkipEnd, %SkipEndValue%
    GuiControl,, SendtoMail, %SendtoMailValue%

    Gui, Submit
    if (Verbose)
    {
        AddLog("ClaimInd: " ClaimInd)
        AddLog("RoundMinutes: " RoundMinutes)
        AddLog("GameVersion: " GameVersion)
        AddLog("Ignore0: " Ignore0)
        AddLog("SkipBegin: " SkipBegin)
        AddLog("SkipEnd: " SkipEnd)
    }

    Gui, Main:Default
    */

return

AddLog(newString)
{
    Gui MainGUI:Default
    NewEntry := LV_Add("", GetFTime() " || " newString)
    LV_Modify(NewEntry, "Vis")
}

CheckMouse:
    MouseGetPos, newx, newy
    if (newx == oldx) and (newy == oldy)
    {
        Mouse_Moved := false
    }
    else
    {
        Mouse_Moved := true
    }
    oldx := newx
    oldy := newy
return

#MaxThreadsPerHotkey 2
PauseButton:
    if not (Paused)
    {
        Paused := true
        AddLog("Pausing...")
        GuiControl,MainGui:, StatusBar, Paused
        GuiControl,MainGui:, PButton, Resume
    }
    else
    {
        Paused := false
        AddLog("Resuming...")
        GuiControl,MainGui:, PButton, Pause
    }
return
#MaxThreadsPerHotkey 1

StartButton:
    Running := True
    Timing := False
    NextRoundMinutes := RoundMinutes
    NextRoundSeconds := 0
    Round_Part := 0
    CCon_Timer := 60
    FormatTime, Time,, hh:mm:ss tt
    AddLog("Starting")

    if (Verbose)
    {
        AddLog("ClaimInd: " ClaimInd)
        AddLog("RoundMinutes: " RoundMinutes)
        AddLog("GameVersion: " GameVersion)
        AddLog("Ignore0: " Ignore0)
        AddLog("SkipBegin: " SkipBegin)
        AddLog("SkipEnd: " SkipEnd)
    }

    GuiControl,, StatusBar, Running
    Sleep 1000

    setTimer, CheckMouse, 10

    TotalSent := 0
    TotalClaimed := 0

    While (Running)
    {
        ;Prepare your anus!
        if not (Timing)
        {
            Timing := RunStep()
        }



        if (Timing == true) and (Running == true)
        {
            NextRoundSeconds--

            if (NextRoundSeconds < 0)
            {
                if (NextRoundMinutes == 0)
                {
                    Timing := False
                    Rounds ++
                    GuiControl,MainGui:, RoundsText, %Rounds% rounds
                    GuiControl,MainGui:, StatusBar, Running
                }
                else
                {
                    NextRoundSeconds = 59
                    NextRoundMinutes--

                    seconds := SubStr("0" NextRoundSeconds, -1)
                    GuiControl,MainGui:, StatusBar, %NextRoundMinutes%:%seconds% until next round
                    Sleep, (1000)
                }
            }
            else
            {
                seconds := SubStr("0" NextRoundSeconds, -1)
                GuiControl,MainGui:, StatusBar, %NextRoundMinutes%:%seconds% until next round
                Sleep, (1000)
            }
        }
    }

    setTimer, CheckMouse, Off

    AddLog("Stopped")
    AddLog("Total Hearts Sent: " TotalSent)
    AddLog("Total Hearts Claimed: " TotalClaimed)
    AddLog("Ratio: " TotalClaimed/(TotalClaimed + TotalSent))

    AddLog("") ; sometimes the last line isn't written to log.

    DumpLog()

    GuiControl,MainGui:, StatusBar, Stopped

return

StopButton:
    if (Running)
    {
        Running := False
        AddLog("Attempting to stop!")
    }
    else
    {
        AddLog("There is no active thread.")
    }
return


RunStep()
{
    ; RunStep utilizes all singular functions to run a
    ; loop comprising of the entire run time logic.
    ; This loop allows escaping of run time logic, based
    ; on user input. Letting the user escape the current
    ; thread on mouse_move

    ;Initialize Global Variables
    global Running
    global Mouse_Moved
    global Round_Part
    global Result
    global Section
    global ClaimStage
    global ClaimInd
    global ResetStage
    global SendStage
    global SendSubStage
    global Paused
    Global RoundMinutes
    Global NextRoundMinutes
    Global HeartsSent
    Global TotalSent
    Global ToalClaimed
    Global SkipBegin
    Global SkipEnd
    Global CCon_Timer
    Global ScrollSpeed
    Global TTC
    Global ScrollDelay

    if (!Mouse_Moved) and (!Paused)
    {
        ;GuiControl,, StatusBar, Running

        ;GetConnection()
        Next_Step := true
        Result := false

        if (CCon_Timer == 0)
        {
            ;CCol_Timer := 60
            Result := CheckConnection()

            if (Result)
            {
                CCon_Timer := 60
            }
        }
        else
        {
            CCon_Timer := CCon_Timer - 1

            if (Round_Part == 0) and (Next_Step == true) ;Round started, find position
            {
                ;AddLog("Checking for section...")
                Result := CheckSection(Section)
                ;Check for Position

                if (Result)
                {
                    if (Section ==  1)
                    {
                        if !(SkipBegin)
                        {
                            AddLog("Started at main.")
                            AddLog("Going to mail...")
                            Round_Part := 2 ;At Main, go to mail checking
                        }
                        else
                        {
                            AddLog("Started at main.")
                            AddLog("Resetting friend list...")
                            Round_Part := 4
                            ResetStage := 1
                        }
                    }
                    else
                    {
                        AddLog("Started outside of main.")
                        AddLog("Returning to main...")
                        Round_Part := 1 ;Not at main, return to main
                    }
                }
            }

            if (Round_Part == 1) and (Next_Step == true)
            {
                Next_Step := false

                Result := StepToMain(Section)

                if (Result)
                {
                    if !(SkipBegin)
                    {
                        AddLog("Returned to main.")
                        AddLog("Going to mail...")
                        Round_Part := 2
                    }
                    else
                    {
                        AddLog("Returned to main.")
                        AddLog("Resetting friend list...")
                        Round_Part := 4
                        ResetStage := 1
                    }
                }
            }

            if (Round_Part == 2) and (Next_Step == true)
            {
                Next_Step := False

                Result := EnterMailbox()

                if (Result)
                {
                    AddLog("Mailbox opened.")
                    AddLog("Beginning claim process...")
                    Round_Part := 3
                    failcounter := 0
                    ClaimStage := 1
                }
            }

            if (Round_Part == 3) and (Next_Step == true)
            {
                Next_Step := False

                ;Claim Mail
                if (ClaimInd == 1)
                {
                    Result := ClaimAllInd()
                }
                else
                {
                    Result := ClaimAll()
                }

                if (Result == 1) {
                  Round_Part := 2
                }
                else if (Result)
                {
                    AddLog("Mail claimed.")
                    AddLog("Resetting friend list...")
                    Round_Part := 4
                    ResetStage := 1
                }
            }

            if (Round_Part == 4) and (Next_Step == true)
            {
                Next_Step := False

                ;Reset friend list

                Result := ResetList()

                if (Result)
                {
                    AddLog("Friend list reset.")
                    AddLog("Returning to top...")
                    Round_Part := 5
                }
            }

            if (Round_Part == 5) and (Next_Step == true)
            {
                ;AddLog("Returning to top...")

                Result := ScrollUp()

                if (Result)
                {
                    AddLog("Returned to top.")
                    AddLog("Sending hearts...")
                    Round_Part := 6
                    SendStage := 1
                    SendSubStage := 0
                    HeartsSent := 0
                }
            }

            if (Round_Part == 6) and (Next_Step == true)
            {
                Next_Step := False

                ;Find and send hearts!
                ;AddLog("Sending Hearts...")

                failcounter := 0
                Result := SendHearts()
                if (Result)
                {
                    if !(SkipEnd)
                    {
                        AddLog(HeartsSent " hearts sent.")
                        AddLog("Opening Mailbox...")
                        Round_Part := 7
                    }
                    else
                    {
                        AddLog(HeartsSent " hearts sent.")
                        AddLog("Finished Round.")
                        Rounds += 1
                        GuiControl,MainGui:, RoundsText, %Rounds% rounds
                        NextRoundMinutes := RoundMinutes
                        Round_Part := 0
                        return true
                    }
                }
            }



            if (Round_Part == 7) and (Next_Step == true)
            {
                ;AddLog("Opening Mailbox...")
                Next_Step := False

                ;Open Mailbox
                Result := EnterMailbox()

                if (Result)
                {
                    AddLog("Mailbox opened.")
                    AddLog("Beginning final claim process...")
                    Round_Part := 8
                    ClaimStage := 1
                }
            }

            if (Round_Part == 8) and (Next_Step == true)
            {
                Next_Step := False

                ;Claim Mail
                if (ClaimInd = 1)
                {
                    Result := ClaimAllInd()
                }
                else
                {
                    Result := ClaimAll()
                }

                if (Result == 1) {
                  Round_Part := 7
                }
                else if (Result)
                {
                    AddLog("Final claim process complete.")
                    AddLog("Finished Round.")
                    Rounds += 1
                    GuiControl,MainGui:, RoundsText, %Rounds% rounds
                    NextRoundMinutes := RoundMinutes
                    Round_Part := 0
                    return true
                }
            }
        }
    }
    else
    {
        sleep 3000
    }

    ;Adding variable sleep depending on instruction. Hope this works.
    sleep 100 ;Sleep for one second, allowing things to move at a safe pace
    return false
}

DumpLog()
{
    Gui MainGUI: Default

    GuiControl,MainGui:, StatusBar, Writing Log File

    FormatTime gTime, hh:mm:ss tt dd`, MMM`, yyyy

    FileAppend Log made at %gTime%, YATTHS.log

    LVCount := LV_GetCount()
    r := 1

    while (r < LVCount)
    {
        LV_GetText(GText, r)
        FileAppend `n%GText%, YATTHS.log

        r := r + 1
    }

    FileAppend `n`n, YATTHS.log

    r := LVCount
    While (r > 0)
    {
        LV_Delete(r)

        r := r - 1
    }
}

GetFTime()
{
    FormatTime gTime, hh:mm:ss tt
    return gTime
}

ScrollUp()
{
    Global ScrollSpeed

    if not CheckImage("Rank_1.png")
    {
        scrollY := 270 + ScrollSpeed
        WinActivate, Nox ahk_Class QtQ5WindowIcon
        DragFrom(217,270,217,scrollY,true)
        return False
    }
    else
    {
        return True
    }
}

SendHearts()
{
    Global SendStage
    Global SendSubStage
    Global getX
    Global getY
    Global HeartsSent
    Global TotalSent
    Global Ignore0
    Global Verbose
    Global ScrollDelay
    next_sub := true

    WinActivate, Nox ahk_Class QtQ5WindowIcon
    if (SendStage == 1) and (next_sub == true)
    {
        if (Verbose)
        {
            AddLog("Searching for heart...")
        }
        next_sub := false
        checking := false

        if (Ignore0 == 1)
        {
            WinActivate, Nox ahk_class Qt5QWindowIcon
            PixelSearch, Osx, Osy, 260, 300, 280, 500, 0xFFFFFF, 3, Fast
            if ErrorLevel
            {
                return true
            }
            else
            {
                checking := true
            }
        }
        else
        {
            checking := true
        }

        if GetHeart(getX, getY) and (checking)
        {
            if (Verbose)
            {
                AddLog("Heart found at " getX "," getY)
            }
            SendStage := 2
            SendSubStage := 1
            return false
        }
        else
        {
            if (SendStage == 1)
            {
                if CheckImage("Plus_Button.png")
                {
                    Return true
                }
                else
                {
                    DragFrom(217,285,217,270,true)
                    return false
                    sleep ScrollDelay ;Pending variable sleep implementation
                }
            }
            else
            {
                Return false
            }
        }
    }

    if (SendStage == 2) and (next_sub == true)
    {
        ;AddLog("Sending Heart to " getX "," getY)
        SendResult := SendHeart(getX, getY)
        if (SendResult)
        {
            if (Verbose)
            {
                AddLog("Heart sent")
            }
            HeartsSent++
            TotalSent++
            SendStage := 1
            return false
        }
        else
        {
            return false
        }
    }
    return false
}

SendHeart(x, y)
{
    Global TTCS
    Global TTCC
    Global Verbose
    Global SendSubStage
    Global failcounter

    next_sub := true

    if (SendSubStage == 1) and (next_sub)
    {
        next_sub := false

        ;AddLog("Sending Heart at " x "," y)

        ClickPoint(x, y)
        SendSubStage := 2
        failcounter := 0
    }

    if (SendSubStage == 2) and (next_sub)
    {
        if CheckImage("Give_Heart.png")
        {
            next_sub := false
            sleep TTCS
            ClickPoint(280,450)
            SendSubStage := 3
            failcounter := 0
        }
        else
        {
            failcounter := failcounter + 1

            if (failcounter > 30)
            {
                SendSubStage := SendSubStage - 1
                failcounter := 0
            }
        }
    }

    if (SendSubStage == 3) and (next_sub)
    {
        if CheckImage("TsumTsum.png")
        {
            next_sub := false
            Global TTCC
            ClickPoint(200, 590)
            SendSubStage := 4

            return true
        }
        else
        {
            failcounter := failcounter + 1

            if (failcounter > 30)
            {
                SendSubStage := SendSubStage - 1
                failcounter := 0
            }
        }
    }
    /*
    if (SendSubStage == 4) and (next_sub)
    {
        if CheckImage("Play_Button.png")
        {
            next_sub := false
            return true
        }
    }
    */
    return false
}

ResetList()
{
    Global ResetStage
    if CheckImage("Play_Button.png") and (ResetStage == 1)
    {
        ClickPoint(200, 650)
        ResetStage := 2
    }

    if CheckImage("Start_Pink.png")
    {
        ClickPoint(70, 650)
        ResetStage := 3
    }

    if CheckImage("Play_Button.png") and (ResetStage == 3)
    {
        return true
    }
    else
    {
        return false
    }
}

ClaimAll()
{
    Global ClaimStage
    Global TTCS
    Global TTCC
    Global failcounter

    NextPart := true

    if (ClaimStage == 1) and (NextPart)
    {
        NextPart := False
        if CheckImage("Claim_All.png")
        {
            ClickPoint(280,565)
            ClaimStage := 2
            failcounter := 0
        }
    }

    if (ClaimStage == 2) and (NextPart)
    {
        NextPart := False
        if CheckImage("Rec_Gift.png")
        {
            Sleep TTCS
            ClickPoint(290,450)
            ClaimStage := 3
        }
    }

    if (ClaimStage == 3) and (NextPart)
    {
        NextPart := False
        if CheckImage("Info_Received.png")
        {
            Sleep TTCC
            ClickPoint(200,560)
            ClaimStage := 4
        }
        else
        {
            failcounter := failcounter + 1

            if (failcounter > 30)
            {
                ClaimStage := ClaimStage - 1
                failcounter := 0
            }
        }
    }

    if (ClaimStage != 5) and (ClaimStage != 6)
    {
        NextPart := False
        if CheckImage("No_Claim_All.png")
        {
            failcounter := failcounter + 1
            if (failcounter = 30)
            {
                if not (ClaimStage == 4)
                {
                    AddLog("No mail to claim!")
                }
                else
                {
                    AddLog("Mail claimed!")
                }

                ClaimStage := 5
                failcounter := 0
            }
        }
        else
        {
            if (ClaimStage == 4)
            {
                AddLog("Mail claimed! Skill tickets remaining!")
                ClaimStage := 5
            }
        }
    }

    if (ClaimStage == 5) and (NextPart)
    {
        NextPart := False
        if CheckImage("Close_Mail.png")
        {
            AddLog("Exiting Mail")
            ClaimStage := 6
        }
    }

    if (ClaimStage == 6) and (NextPart)
    {
        NextPart := False
        if CheckImage("Play_Button.png")
        {
            Return true
        }
        else
        {
            if (ClaimStage == 6)
            {
                if CheckImage("Close_Mail.png")
                {
                    ClickPoint(200, 650)
                }
            }
            Return false
        }
    }
}

; Acts as the step machine for the individual claim process.
;
; Returns 0, if not done
;         1, if done, but reprocess
;         2, if done
ClaimAllInd()
{
    Global Verbose
    Global ClaimStage
    Global TotalClaimed
    Global SendtoMail
    Global TTCS
    Global TTCC
    Global failcounter

    NextPart := true
    static heartsClaimed := 0
    static reopenMailbox := false

    ; ClaimStage 1. Scan for the Heart_Part.png and click the Check button. Set
    ; us to "done" if there is none found.
    if (ClaimStage == 1) and (NextPart)
    {
        NextPart := false

        if CheckImage("Heart_Part.png", getX, getY)
        {
            offX := getX + 196
            offY := getY - 13
            if (Verbose)
            {
                AddLog("Found Heart Part at " getX "," getY)
                AddLog("Getting mail at " offX "," offY)
            }
            Sleep TTCS
            ClickPoint(offX,offY)
            ClaimStage := 2
            failcounter := 0
        }
        else
        {
            failcounter := failcounter + 1

            ; if we've claimed at least one heart, no need to wait for 30 more
            ; failures
            if (heartsClaimed > 0)
            {
              ClaimStage := "Done"
            }

            if (failcounter = 30)
            {
                AddLog("No received hearts detected!")
                ClaimStage := "Done"
            }
        }
    }

    ; ClaimStage 2. Scan for the message in the dialog and click the OK button.
    if (ClaimStage == 2) and (NextPart)
    {
        NextPart := false

        if CheckImage("Rec_Individual.png")
        {
            Sleep TTCS
            ClickPoint(288,450)
            ClaimStage := 3
        }
        else
        {
            if CheckImage("Give_Heart_Mail.png")
            {
                if (SendtoMail)
                {
                    Sleep TTCS
                    ClickPoint(290,450)
                }
                else
                {
                    Sleep TTCS
                    ClickPoint(120,450)
                }
                ClaimStage := 3
            }
        }
    }

    ; ClaimStage 3. Wait for the Tsum Tsum logo in the status dialog and click
    ; on the screen to dismiss it. If it never appears, try to scan for the
    ; the message again.
    ;
    ; todo. Is the assumption that the claim was successful and the next claim
    ; happened? Dodgy.
    if (NextPart) and (ClaimStage == 3)
    {
        NextPart := false
        if CheckImage("TsumTsum.png")
        {
            Sleep TTCC
            ClickPoint(200,560)
            ClaimStage := 1
            heartsClaimed++
            TotalClaimed++
        }
        else
        {
            failcounter := failcounter + 1

            if (failcounter > 30)
            {
                ClaimStage := ClaimStage - 1
                failcounter := 0
            }
        }
    }

    ; If we're somehow not "done" and not "exit", look for No_Claim_All.png and
    ; set us to "done".
    if (ClaimStage != "Exit") and (ClaimStage != "Done") and (NextPart)
    {
        NextPart := false
        if CheckImage("No_Claim_All.png")
        {
            AddLog("No mail left to claim")
            ClaimStage := "Done"
        }
    }

    ; We're done. Log your logs amd set your states.
    if (ClaimStage == "Done") and (NextPart)
    {
      NextPart := false

      if CheckImage("Close_Mail.png") {
        reopenMailbox := (heartsClaimed == 100)

        AddLog("Exiting Mail")
        AddLog(heartsClaimed " hearts claimed.")
        heartsClaimed := 0  ; ready for next time ...

        ClaimStage := "Exit"
      }
    }

    ; Exit the mailbox. If we see the play button, it's okay. If we still see
    ; the Close button, we're not.
    ;
    ; todo. How would we need to click the Close_Mail.png again?
    if (NextPart) and (ClaimStage == "Exit") {
      NextPart := false

      if CheckImage("Play_Button.png") {
        if (reopenMailbox) {
          return 1
        }
        else {
          return 2
        }
      }
      else
      {
        if CheckImage("Close_Mail.png")
        {
          ClickPoint(200, 650)
        }
      }
    }

    return 0
}

EnterMailbox()
{
    if CheckImage("Mail_Box.png")
    {
        Return True
    }

    else
    {
        ClickPoint(345, 180)
        Return False
    }
}

StepToMain(section)
{
    if (section == 1)
    {
        AddLog("Already at main")
        ;Do nothing! We're already there.
    }

    if (section == 2)
    {
        if CheckImage("Close_Mail.png")
        {
            ClickPoint(200, 650)
        }
    }

    if (section == 3)
    {
        if CheckImage("Close_Mail.png")
        {
            ClickPoint(200, 650)
        }
    }

    if (section == 4)
    {
        if CheckImage("Back.png")
        {
            ClickPoint(60,650)
        }
    }

    if CheckImage("Play_Button.png")
    {
        return true
    }
    else
    {
        return false
    }
}

ClickPoint(x, y)
{
    ;Global TTC
    ;sleep TTC
    ;AddLog("Attempting to click at x"x " y"y)
    WinActivate, Nox ahk_Class Qt5QWindowIcon
    MouseGetPos, mouseX, mouseY

    cX := "x" x
    cY := "y" y

    ;ControlClick, %cX% %cY%, Nox ahk_class Qt5QWindowIcon

    ;ControlClick, %cX% %cY%, Nox ahk_class Qt5QWindowIcon,,,, D ,,, NA
    MouseMove, %x%, %y%
    ControlClick, %cX% %cY%, Nox ahk_Class Qt5QWindowIcon
    mouseMove, %mouseX%, %mouseY%
    ;ControlClick, %cX% %cY%, Nox ahk_class Qt5QWindowIcon,,,, U ,,, NA

    ;ControlClick, x205 y565, Nox ahk_class Qt5QWindowIcon
}

DragFrom(x, y, dirX, dirY, literal)
{
    WinActivate, Nox ahk_Class Qt5QWindowIcon
    mouseGetPos, origX, origY

    if (literal)
    {
        x2 := dirX
        y2 := dirY
    }
    else
    {
        x2 := x + dirX
        y2 := y + dirY
    }

    cX := "x" x
    cY := "y" y

    cX2 := "x" x2
    cY2 := "y" y2

    ;MouseMove, %x%, %y%

    ;MouseMove, %x2%, %y2%

    MouseClickDrag, L, %x%, %y%, %x2%, %y2%, 100

    ;ControlClick, %cX% %cY%, Nox ahk_Class Qt5QWindowIcon,,,, D ,,, NA

    ;MouseMove, %x2%, %y2%
    ;ControlClick, %cX2% %cY2%, Nox ahk_Class Qt5QWindowIcon,,,, U ,,, NA

    ;ControlClick, x217 y270 , Nox ahk_class Qt5QWindowIcon,,,, D ,,, NA
    ;ControlClick, x217 y500 , Nox ahk_class Qt5QWindowIcon,,,, U ,,, NA

    mouseMove, %origX%, %origY%, 0

    sleep 1000
}

CheckImage(file,byRef getX := -1 ,byRef getY := -1)
{
    global GameVersion
    global Verbose
    global n_Width
    global n_Height
    global win_Width
    global win_Height
    ;AddLog("Searching for " file " within bounds of " n_Width "x" n_Height)
    WinActivate, Nox ahk_Class Qt5QWindowIcon

    if (Verbose)
    {
        AddLog("Checking for: images\" GameVersion "\" file)
    }

    ImageSearch resultX, resultY, 0, 0, win_Width, win_Height, *50 images\%GameVersion%\%file%

    getX := resultX
    getY := resultY

    if (ErrorLevel == 0)
    {
        return True
    }
    else
    {
        return False
    }
}

GetHeart(byRef getX, byRef getY)
{
    PixelSearch, getX, getY, 320, 240, 380, 550, 0x8B3DE1, 3, Fast
    if (ErrorLevel == 0)
    {
        return True
    }
    else
    {
        return False
    }
}

CheckSection(byRef appSection)
{
    result := False
    appSection := 0

    ;Start Main Page
    if CheckImage("Play_Button.png")
    {
        result := True
        appSection := 1
    }
    ;end Main Page

    ;Start Mailbox Page
    if CheckImage("Mail_Box.png")
    {
        result := True
        appSection := 2
    }
    ;End Mailbox Page

    ;Start Card Page
    if CheckImage("How_To_Play.png")
    {
        result := True
        appSection := 3
    }
    ;End Card Page

    ;Start Play Page
    if CheckImage("Start_Pink.png")
    {
        result := True
        appSection := 4
    }
    ;End Play Page
    return result
}

CheckConnection()
{
    ;AddLog("Maintaining connection...")
    result := True

    if CheckImage("Error_1.png")
    {
        AddLog("Connection error, trying to resume...")
        ClickPoint(280,440)
        result := False
    }
    if CheckImage("Error_1Retrieve.png")
    {
        AddLog("Connection error, trying to resume...")
        ClickPoint(280,440)
        result := False
    }
    if CheckImage("Error_6.png")
    {
        AddLog("Connection error, trying to resume...")
        ClickPoint(280,440)
        result := False
    }
    if CheckImage("Error_Timeout.png")
    {
        AddLog("Connection error, trying to resume...")
        ClickPoint(280,440)
        result := False
    }

    return result
}
