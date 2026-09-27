import Quickshell
import Quickshell.Io
import QtQuick
import "../Theme"

Item {
    id: root

    implicitWidth: button.width
    implicitHeight: button.height

    Rectangle {
        id: button

        implicitWidth: 30
        implicitHeight: 24
        radius: Theme.radius
        color: Theme.backgroundAlt

        Text {
            anchors.centerIn: parent

            text: "⏻"
            color: Theme.foreground
            font.pixelSize: 16
        }

        MouseArea {
            anchors.fill: parent

            onClicked: popup.visible = !popup.visible
        }
    }

    PopupWindow {
        id: popup

        anchor.item: button

        implicitWidth: 180
        implicitHeight: 190

        visible: false
        color: Theme.backgroundAlt
        grabFocus: true

        Rectangle {
            anchors.fill: parent
            color: Theme.backgroundAlt
            radius: Theme.radius

            Column {
                anchors {
                    fill: parent
                    margins: 12
                }

                spacing: 6

                Text {
                    text: "Power"
                    color: Theme.foreground
                    font.bold: true

                    bottomPadding: 6
                }

                Action {
                    text: "Lock"
                    command: ["loginctl", "lock-session"]
                }

                Action {
                    text: "Suspend"
                    command: ["systemctl", "suspend"]
                }

                Action {
                    text: "Reboot"
                    command: ["systemctl", "reboot"]
                }

                Action {
                    text: "Power off"
                    dangerous: true
                    command: ["systemctl", "poweroff"]
                }
            }
        }
    }

    component Action: Rectangle {
        required property string text
        required property var command
        property bool dangerous: false

        implicitWidth: parent.width
        implicitHeight: 32
        radius: 4

        color: mouse.containsMouse
            ? (dangerous ? "#5a2634" : Theme.background)
            : "transparent"

        Text {
            anchors {
                left: parent.left
                leftMargin: 8
                verticalCenter: parent.verticalCenter
            }

            text: parent.text
            color: dangerous ? Theme.danger : Theme.foreground
        }

        MouseArea {
            id: mouse

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Quickshell.execDetached(parent.command)
                popup.visible = false
            }
        }
    }
}
