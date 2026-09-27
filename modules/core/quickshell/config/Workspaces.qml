import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../Theme"

Row {
    spacing: 4

    Repeater {
        model: 10

        Rectangle {
            required property int index

            width: 28
            height: 24
            radius: Theme.radius

            color: {
                const workspaceId = index + 1
                return Hyprland.focusedWorkspace?.id === workspaceId
                    ? Theme.accent
                    : Theme.backgroundAlt
            }

            Text {
                anchors.centerIn: parent

                text: index + 1
                color: Hyprland.focusedWorkspace?.id === index + 1
                    ? Theme.background
                    : Theme.foreground

                font.pixelSize: 13
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
