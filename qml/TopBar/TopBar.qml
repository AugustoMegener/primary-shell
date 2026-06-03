import Quickshell
import QtQuick
import "../Theme"
import "./TopBarLeft"
import "./TopBarRight"


// qmllint disable uncreatable-type
PanelWindow { 
  id: bar

  anchors { top: true; left: true; right: true }
  implicitHeight: 40
  color: Theme.transparent

  TopBarLeft { }
  TopBarRight { }
}
