pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import "./TopBar"
import "./Border"
import "./SideBar"

ShellRoot { 
    id: root 

    SideBar {
      side: "left" 
    }
    SideBar {
      side: "right" 
    }
    TopBar { }


    Variants {
        model: Quickshell.screens
        delegate: Component {
            Border {
                required property ShellScreen modelData
                screen: modelData
            }
        }
    }
}
