import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Services.SystemTray

import "../PowerMenu"
import "../../Theme"
import "./PowerMenuOption"

PanelWindow {
  id: modal

  color: "transparent"
  visible: PowerMenuState.isPowerMenuOpen || card.opacity > 0

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }


  Item {
    anchors.fill: parent

    property bool isOpen: PowerMenuState.isPowerMenuOpen

    onIsOpenChanged: {
      if (isOpen) {
        cardCloseAnim.stop()
        card.opacity = 0
        cardTranslate.y = 40
        cardOpenAnim.start()
      } else {
        cardOpenAnim.stop()
        cardCloseAnim.start()
      }
    }

    Rectangle {
      id: card

      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottomMargin: 10

      implicitWidth: content.implicitWidth - 15
      implicitHeight: content.implicitHeight - 15

      radius: 12
      color: Theme.foreground
      border.color: Theme.border

      opacity: 0

      transform: Translate {
        id: cardTranslate
        y: 40
      }

      NumberAnimation {
        id: cardOpenAnim

        target: cardTranslate
        property: "y"
        to: 0
        duration: 300
        easing.type: Easing.OutCubic

        onStarted: card.opacity = 1
      }

      NumberAnimation {
        id: cardCloseAnim

        target: cardTranslate
        property: "y"
        to: 40
        duration: 300
        easing.type: Easing.InCubic

        onStopped: {
          card.opacity = 0
          cardTranslate.y = 40
        }
      }

      Row {
        id: content

        anchors.centerIn: parent
        spacing: -32

        property int optionSize: 50

        PowerMenuOption {
          hasRadiusLeft: true
          label: "Reboot"
          backgroundColor: Theme.foreground
          iconPath: "rotate-ccw.svg"
          buttonColor: Theme.buttonColor
          buttonLightColor: Theme.colorLightYellow
          buttonWidth: content.optionSize
          buttonHeight: content.optionSize
          buttonRadius: 12
          command: "hyprshutdown --post-cmd 'systemctl reboot'"
        }

        PowerMenuOption {
          label: "Shutdown"
          backgroundColor: Theme.foreground
          iconPath: "power.svg"
          buttonColor: Theme.buttonColor
          buttonLightColor: Theme.colorLightRed
          buttonWidth: content.optionSize
          buttonHeight: content.optionSize
          buttonRadius: 12
          command: "hyprshutdown --post-cmd 'systemctl poweroff'"
        }

        PowerMenuOption {
          label: "Hibernate"
          backgroundColor: Theme.foreground
          iconPath: "zzz.svg"
          buttonColor: Theme.mainButtonColor
          buttonLightColor: Theme.colorLightBlue
          buttonWidth: content.optionSize
          buttonHeight: content.optionSize
          buttonRadius: 12
          command: "systemctl hibernate"
        }

        PowerMenuOption {
          label: "Lock"
          backgroundColor: Theme.foreground
          iconPath: "lock.svg"
          buttonColor: Theme.buttonColor
          buttonLightColor: Theme.colorLightPurple
          buttonWidth: content.optionSize
          buttonHeight: content.optionSize
          buttonRadius: 12
          command: "hyprlock"
        }

        PowerMenuOption {
          hasRadiusRight: true
          label: "Log out"
          backgroundColor: Theme.foreground
          iconPath: "log-out.svg"
          buttonColor: Theme.buttonColor
          buttonLightColor: Theme.colorLightGreen
          buttonWidth: content.optionSize
          buttonHeight: content.optionSize
          buttonRadius: 12
          command: "hyprctl dispatch exit"
        }
      }
    }
  }
}
