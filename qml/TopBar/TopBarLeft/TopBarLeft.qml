import QtQuick
import "../../SideBar/SideBarToggle"

import "../../Theme"

Row {
  id: workspaces
  spacing: 33

  SideBarToggle { 
    side: "left"
  }
  Row {
    spacing: 4
    HyprWorkspaces { }
  }
}
