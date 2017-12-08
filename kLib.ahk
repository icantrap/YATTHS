#NoEnv
#SingleInstance Force

;Implements custom dynamic GUI handling
;
; Version 1.0
;


class kGUI
{
    name := ""
    FieldCount := 0
    width := 0
    height := 0
    title := 0

    Create(guiName, width, height, title)
    {
        this.title := title
        this.name := guiName
        this.width := width
        this.height := height
        GUI, %guiName%: New,, %title%
    }

    ShowGUI()
    {
        myName := this.name
        myWidth := this.width
        myHeight := this.height
        Gui, %myName%: Show, w%myWidth% h%myHeight%
    }

    HideGUI()
    {
        myName := this.name
        Gui, %myName%: Hide
    }

    ResizeGUI(width, height)
    {
        myName := this.name
        this.width := width
        this.height := height
        myTitle = this.title
        IfWinActive, %mytitle%
        {
            GUI, %myName%: Show, w%width% h%height%
        }
    }
}

class SettingField
{
    Parent := ""
    Offset := 0
    myLabel := ""
    myControl := ""
    FieldShift := 0
    ControlShift := 0
    FieldFloat := 0
    ControlFloat := 0

    Init(parent)
    {
        this.Parent := parent
        this.Offset := parent.FieldCount
        parent.FieldCount += 1
    }

    AddField(name, variables, title)
    {
        if (title = "")
        {
            this.myLabel := name
            myParent := this.Parent.name
            calcOffset := (20 + (this.Offset * 24)) + this.FieldFloat
            calcWidth := this.Parent.width - 20
            GUI, %myParent%: Add, Text, hwnd%name% x10 y%calcOffset% w%calcWidth% 0x10
        }
        else
        {
            this.myLabel := name
            myParent := this.Parent.name
            calcOffset := (10 + (this.Offset * 24)) + this.FieldFloat
            calcShift := 10 + this.FieldShift
            GUI, %myParent%: Add, Text, %variables% hwnd%name% x%calcShift% y%calcOffset% h21, %title%
        }
    }

    AddControl(type, name, variables, value)
    {
        this.myControl := name
        myParent := this.Parent.name
        calcOffset := (10 + (this.Offset * 24))  + this.ControlFloat
        calcShift := 180 + this.ControlShift
        Gui, %myParent%:Add, %type%, hwnd%name% %variables% x%calcShift% y%calcOffset%, %value%
    }
}

SetHoverText(CtrlHwnd, HoverText = "", msg = "", hwnd = "")
{
	static CtrlArray       := []
	static WM_MOUSEMOVE    := OnMessage( 0x200, "SetHoverText" )
	static WM_NCMOUSELEAVE := OnMessage( 0x2A2, "SetHoverText" )
	static ChangedHwnd

	; Setup hover control
	if !msg ; Called from fuction, not OnMessage.
	{
		ControlGetText, OrigText,, ahk_id %CtrlHwnd% ; GuiControl can't get the control's text of a non-default GUI.
		GuiHwnd := DllCall("GetParent", "UInt", CtrlHwnd)
		CtrlArray[CtrlHwnd] := { OrigText: OrigText, HoverText: HoverText, GuiHwnd: GuiHwnd }

		SetTimer, __CheckIfMouseIsOutsideGui, 100 ; WM_NCMOUSELEAVE won't execute when mouse moving too fast.
		Return
	}

	MouseGetPos,,,, hwnd, 2 ; Button / Radio / Checkbox don't need this line.

	if CtrlArray.HasKey(hwnd) ; Mouse is over at a defined control.
	{
		if !ChangedHwnd ; Button's text only change once, when mouse moving inside the control.
		{
			;GuiControl,, %hwnd%, % CtrlArray[hwnd]["HoverText"]
            ToolTip % CtrlArray[hwnd]["HoverText"]
			ChangedHwnd := hwnd
		}
	}
	else if ChangedHwnd
	{
		;GuiControl,, %ChangedHwnd%, % CtrlArray[ChangedHwnd]["OrigText"]
        ToolTip
		ChangedHwnd := ""
	}

	Return

	__CheckIfMouseIsOutsideGui:
		if !ChangedHwnd
			Return

		MouseGetPos,,, hWin
		if ( hWin != CtrlArray[ChangedHwnd]["GuiHwnd"] )
		{
			;GuiControl,, %ChangedHwnd%, % CtrlArray[ChangedHwnd]["OrigText"]
            ToolTip
			ChangedHwnd := ""
		}
	Return
}