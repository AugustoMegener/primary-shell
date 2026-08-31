
import QtQuick
import QtQuick.Layouts
import "../../Components/VolumeManager/"
import "../../Components/BrightnessManager/"
import "../../Components/PowerProfileManager/"
import "../../Theme/"

Column{

  Layout.preferredHeight: quickSetting.implicitHeight + 20
  spacing: 10

  Text {
    text: qsTr("Quick Settings")
    font.pixelSize: 15
    font.family: "Bricolage Grotesque"
    font.weight: Font.ExtraBold
    color: Theme.text
    anchors.left: parent.left
    anchors.leftMargin: 16
  }

  Rectangle {

    id: quickSetting
    anchors.left: parent.left
    anchors.right: parent.right
    height: childrenRect.height
    radius: 12
    color: Theme.darkForeground

    Column {
      id: quickSettingsContent
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.margins: 20

      spacing: 20

      Item {
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1

      }

      VolumeManager {
        id: volumeManager
        width: parent.width

      }

      Rectangle {
        height: 1
        width: parent.width
        color: Theme.border

      }
      BrightnessManager {
        id: brightnessManager
        width: parent.width

      }

      Rectangle {
        height: 1
        width: parent.width
        color: Theme.border

      }
      PowerProfileManager {

        width: parent.width
      }
      Item {
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1

      }
    }
  }
}
