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

    anchors {
        top: true
        bottom: true
        left: side == "left"
        right: side == "right"
    }

    mask: Region { item: content }

    property int targetZone: {
        if (side == "left") SideBarState.leftOpen ? SideBarState.leftWidth : 45
        else SideBarState.rightOpen ? SideBarState.rightWidth : 0
    }

    property int targetWidth: targetZone

    onTargetZoneChanged: anim.restart()
Component.onCompleted: {
    content.width = sidebar.targetZone
    exclusiveZone = sidebar.targetZone
}

ParallelAnimation {
    id: anim
    NumberAnimation {
        target: sidebar
        property: "exclusiveZone"
        from: sidebar.exclusiveZone
        to: sidebar.targetZone
        duration: 200
    }
    NumberAnimation {
        target: content
        property: "width"
        from: content.width
        to: sidebar.targetZone
        duration: 200
    }
}

    Rectangle {
        id: content
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: sidebar.side == "left" ? parent.left : undefined
        anchors.right: sidebar.side == "right" ? parent.right : undefined
        color: "#2b2622"
        width: sidebar.side == "left" ? (SideBarState.leftOpen ? SideBarState.leftWidth : 45)
                               : (SideBarState.rightOpen ? SideBarState.rightWidth : 0)
    }
}
