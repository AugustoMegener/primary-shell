import QtQuick
import "../../SideBar/SideBarToggle"

Row {
    id: datetime
    spacing: 8

    DateTime {
        anchors.verticalCenter: parent.verticalCenter
    }

    SideBarToggle { 
        side: "right"
        anchors.verticalCenter: parent.verticalCenter
    }
}
