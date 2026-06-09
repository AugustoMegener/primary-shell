import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Theme"
import "../SideBar"

PanelWindow {
  id: sidebar
  required property string side
  WlrLayershell.layer: WlrLayershell.Layer.Bottom
  aboveWindows: false
  color: "transparent"
  implicitWidth: side == "left" ? SideBarState.leftWidth : SideBarState.rightWidth

  exclusiveZone: {
    if (side == "left") SideBarState.leftOpen ? SideBarState.leftWidth : 45
    else SideBarState.rightOpen ? SideBarState.rightWidth : 0
  }


  Behavior on exclusiveZone {
    NumberAnimation { duration: 3000 }
  }
  anchors {
    top: true
    bottom: true
    left: side == "left"
    right: side == "right"
  }

  mask: Region { item: content }

  Rectangle {
    id: content
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: side == "left" ? parent.left : undefined
    anchors.right: side == "right" ? parent.right : undefined
    color: "#2b2622"
    width: sidebar.exclusiveZone
    Behavior on width {
      NumberAnimation { duration: 3000 }
    }
  }
}
