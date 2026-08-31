//@ pragma UseQApplication
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import "./TopBar"
import "./Border"
import "./SideBar"
import "./KeyboardRgb"
import "./SideBar/SideBarLeft"
import "./SideBar/SideBarRight"
import "./SideBar/SideBarToggle"
import "./Components/PowerMenu/"
import "./DynamicIsland/"

ShellRoot { 
  id: root 


  PowerMenuShortcut {} 


  SideBarRight {

  }
  SideBarLeft {

  }

  Variants {
    model: Quickshell.screens
    delegate: Component {
      Border {
        required property ShellScreen modelData
        screen: modelData
      }
    }
  }
  KeyboardRgb {}

  TopBar {}

  PowerMenu {} 

  DynamicIsland {  
    anchors { top: true } 
    margins.top: 5
  }


}
