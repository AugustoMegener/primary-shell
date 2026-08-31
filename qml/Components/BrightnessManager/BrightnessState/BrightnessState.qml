pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

  FileView {
    id: brightnessFile
    path: "/sys/class/backlight/intel_backlight/brightness"
    watchChanges: true
    onFileChanged: reload()
  }

  FileView {
    id: maxBrightnessFile
    path: "/sys/class/backlight/intel_backlight/max_brightness"
  }

  property real brightnessPct: maxBrightnessFile.text().length
  ? (parseInt(brightnessFile.text()) / parseInt(maxBrightnessFile.text()))
  : 0

  function setBrightness(brightness) {
    Quickshell.execDetached(["brightnessctl", "set", Math.round(brightness * 100) + "%"])
  }
}
