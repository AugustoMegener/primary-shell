import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import "../AudioStatus/AudioState"
import "../../Theme/"
import "../../Misc/RangeSlider/"
import "../../Components/AudioStatus/"
import "../../Components/AudioStatus/AudioState/"

Column {
  Item {
    id: volumeControl
    width: parent.width
    height: childrenRect.height
    Text {
      id: title
      text: qsTr("  Volume")
      font.pixelSize: 13
      font.family: "Bricolage Grotesque"
      font.weight: Font.ExtraBold
      color: Theme.text
      anchors.left: parent.left
    }
    Row {
      anchors.right: parent.right
      anchors.top: parent.top
      anchors.topMargin: 5

      TextField {
        visible: !AudioState.muted
        anchors.verticalCenter: parent.verticalCenter
        id: volumeField
        text: Math.round(AudioState.sink.audio.volume * 100)
        color: Theme.text
        font.pixelSize: 13
        background: Rectangle {
          color: volumeField.activeFocus ? Theme.lightForeground : "transparent"
          radius: 4
        }
        leftPadding: 4
        rightPadding: activeFocus? 4 : 0
        topPadding: 0
        bottomPadding: 0
        implicitWidth: contentWidth + leftPadding + rightPadding
        validator: IntValidator { bottom: 0; top: 100 }
        Keys.onReturnPressed: volumeField.focus = false
        Keys.onEnterPressed: volumeField.focus = false
        onActiveFocusChanged: {
          if (!activeFocus) {
            if (acceptableInput) {
              AudioState.sink.audio.volume = parseInt(text) / 100
            } else {
              text = Qt.binding(function() { return Math.round(AudioState.sink.audio.volume * 100) })
            }
          }
        }
      }
      Text {
        visible: !AudioState.muted
        text: "%"
        color: Theme.text
        font.pixelSize: 13
        anchors.verticalCenter: parent.verticalCenter
      }
      Item {
        visible: !AudioState.muted
        width: 5
        height: 1 
      }
      RangeSlider {
        id: volumeSlider
        visible: !AudioState.muted
        hoverEnabled: true
        anchors.verticalCenter: parent.verticalCenter
        width: 80
        from: 0
        to: 1
        value: AudioState.sink.audio.volume
        onMoved: {
          AudioState.sink.audio.volume = value
        }
      }

      Item {
        width: 5
        height: 1 
      }
      AudioStatus {

        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }
}
