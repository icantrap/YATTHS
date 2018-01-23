#Include %A_ScriptDir%/lib/Gdip_All.ahk

class HeartTracker {
  __New() {
    FileCreateDir, ./.tracker
  }

  ; track a heart based on the absolute location of where the
  ; heart (Heart_Part.png) was found.
  track(heartX, heartY) {
    ; figure out the bounding box for OCR. The offset is (18, -41). The
    ; dimensions are (156, 60)
    x := heartX + 18
    y := heartY - 41

    filename := "./.tracker/" A_Now ".png"

    this._captureMessage(filename, x, y, 156, 60)
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
