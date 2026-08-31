import QtQuick.Controls.Basic
import QtQuick

Switch {
  id: control
  width: 40
  height: 22

  readonly property real shadowTransition: control.visualFocus ? 2.0 : (control.hovered ? 1.0 : 0.0)

  indicator: Rectangle {
    id: track
    implicitWidth: control.width
    implicitHeight: control.height
    x: control.leftPadding
    y: parent.height / 2 - height / 2
    radius: height / 2

    color: control.checked ? "#117449" : "#52412f"

    ShaderEffect {
      anchors.fill: parent
      property real resolutionX: track.width
      property real resolutionY: track.height
      property real boxHalfWidth: track.width / 2
      property real boxHalfHeight: track.height / 2
      property real radiusTopLeft: track.radius
      property real radiusTopRight: track.radius
      property real radiusBottomRight: track.radius
      property real radiusBottomLeft: track.radius
      property real transition: control.shadowTransition

      Behavior on transition {
        NumberAnimation { duration: 100 }
      }

      fragmentShader: "../../assets/shaders/toggle.frag.qsb"
    }

    Rectangle {
      id: thumb

      x: control.checked ? parent.width - width - (control.pressed? -2 : 2) : (control.pressed? 0 : 2)
      anchors.verticalCenter: parent.verticalCenter
      property int size: control.pressed? 23 : 18

      Behavior on size {
        NumberAnimation {
          duration: 100
          easing.type: Easing.InOutQuad
        }
      }

      width: size
      height: size
      radius: height / 2
      color: "#ebdac6"

      Behavior on x {
        NumberAnimation { duration: 100 }
      }

      ShaderEffect {
        anchors.fill: parent
        property real resolutionX: thumb.width
        property real resolutionY: thumb.height
        property real boxHalfWidth: thumb.width / 2
        property real boxHalfHeight: thumb.height / 2
        property real radiusTopLeft: thumb.radius
        property real radiusTopRight: thumb.radius
        property real radiusBottomRight: thumb.radius
        property real radiusBottomLeft: thumb.radius

        fragmentShader: "../../assets/shaders/togglethumb.frag.qsb"
      }
    }
  }
}
