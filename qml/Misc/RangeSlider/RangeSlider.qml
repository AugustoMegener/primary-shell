
import QtQuick
import QtQuick.Controls
import "../../Theme/"

Slider {
  id: volumeSlider
  hoverEnabled: true

  background: Rectangle {
    implicitWidth: parent.width
    implicitHeight: 4
    x: volumeSlider.leftPadding
    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
    width: volumeSlider.availableWidth
    height: 4
    radius: 2
    color: "#26211b"

    Rectangle {
      width: volumeSlider.visualPosition * parent.width
      height: parent.height
      color: "#5A4533"
      radius: 2
    }

    ShaderEffect {
      id: trackShadow

      property real trackWidth: parent.width
      property real trackHeight: parent.height
      property real margin: 2

      width: trackWidth + margin * 2
      height: trackHeight + margin * 2
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2

      property real resolutionX: width
      property real resolutionY: height
      property real boxHalfWidth: trackWidth / 2
      property real boxHalfHeight: trackHeight / 2

      property real radiusTopLeft: boxHalfHeight
      property real radiusTopRight: boxHalfHeight
      property real radiusBottomRight: boxHalfHeight
      property real radiusBottomLeft: boxHalfHeight

       fragmentShader: "../../assets/shaders/slidertrack.frag.qsb"
    }
  }

  handle: Rectangle {
    id: handleRect
    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
    width: 16
    height: 16
    radius: 8
    color: Theme.text

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      acceptedButtons: Qt.NoButton
      cursorShape: volumeSlider.pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor
    }

    ShaderEffect {
      property real thumbWidth: handleRect.width
      property real thumbHeight: handleRect.height
      property real margin: 8

      width: thumbWidth + margin * 2
      height: thumbHeight + margin * 2
      x: (handleRect.width - width) / 2
      y: (handleRect.height - height) / 2

      property real resolutionX: width
      property real resolutionY: height
      property real boxHalfWidth: thumbWidth / 2
      property real boxHalfHeight: thumbHeight / 2

      property real radiusTopLeft: boxHalfWidth
      property real radiusTopRight: boxHalfWidth
      property real radiusBottomRight: boxHalfWidth
      property real radiusBottomLeft: boxHalfWidth

      property real transition: volumeSlider.hovered || volumeSlider.pressed ? 1.0 : 0.0
      Behavior on transition {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
      }

      fragmentShader: "../../assets/shaders/sliderthumb.frag.qsb"
    }
  }
}
