
pragma Singleton
import Quickshell
import QtQuick
import "../../ShellState"

Singleton {
  property bool isPowerMenuOpen: false

  onIsPowerMenuOpenChanged: {
    ShellState.aboveWindows = isPowerMenuOpen
  }
}  
