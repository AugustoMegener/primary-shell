import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Theme"
import "./TopBarLeft"
import "./TopBarRight"
import "../SideBar"

// qmllint disable uncreatable-type
PanelWindow { 
    id: bar
    aboveWindows: false
    WlrLayershell.layer: WlrLayershell.Layer.Bottom
    anchors { top: true; left: true; right: true }
    implicitHeight: 50
    color: "transparent"


    Rectangle {
        width: parent.width 
        height: parent.height
        color: Theme.background

        Item {
            x: 10
            y: 10
            width: parent.width - 20
            height: parent.height - 10

            

            TopBarLeft {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            TopBarRight {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
