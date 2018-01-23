#Include %A_ScriptDir%/lib/Gdip_All.ahk

class HeartTracker {
  __New() {
    FileCreateDir, ./.tracker
  }

  ; track a heart based on the absolute location of where the
  ; heart (Heart_Part.png) was found.
  track(heartX, heartY) {
    ; figure out the bounding box for message capture. The offset is (-57, -45).
    ; The deminsions are (234, 69)
    x := heartX - 57
    y := heartY - 45

    filename := "./.tracker/" A_Now ".png"

    this._captureMessage(filename, x, y, 234, 69)
  }

  _captureMessage(filename, x, y, w, h) {
    pToken := Gdip_Startup()
    bitmap := Gdip_BitmapFromScreen()
    bitmapPart := Gdip_CloneBitmapArea(bitmap, x, y, w, h)

    Gdip_SaveBitmapToFile(bitmapPart, filename)

    Gdip_DisposeImage(bitmap)
    Gdip_DisposeImage(bitmapPart)
    Gdip_Shutdown(pToken)
  }
}
