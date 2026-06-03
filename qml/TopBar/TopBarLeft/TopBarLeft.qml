import QtQuick

Row {
  id: workspaces

  anchors.left: parent.left
  anchors.verticalCenter: parent.verticalCenter
  anchors.leftMargin: 10
  spacing: 4

  HyprWorkspaces { }
}
