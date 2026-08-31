pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import "../SideBar/"

Singleton {
  property bool aboveWindows: false 

  property bool hasTiledWindow: {
    const ws = Hyprland.focusedMonitor?.activeWorkspace
    if (!ws) return false
    return ws.toplevels.values.some(w => !w.lastIpcObject?.floating)
  }

  property real borderClosure: hasTiledWindow? 1 : -1

  property bool sidebarsEnabled: true

  onSidebarsEnabledChanged: {
    SideBarState.leftOpen = false
    SideBarState.rightOpen = false
  }

}
