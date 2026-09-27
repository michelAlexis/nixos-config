import Quickshell
import Quickshell.Services.UPower
import QtQuick

Item {
    id: root

    implicitWidth: button.width
    implicitHeight: button.height

    readonly property var battery: UPower.displayDevice

    Rectangle {
        id: button

        implicitWidth: 58
        implicitHeight: 24
        radius: Theme.radius
        color: Theme.backgroundAlt

        Text {
            anchors.centerIn: parent

            text: battery.ready
                ? "󰁹 " + Math.round(battery.percentage) + "%"
                : "󰁹 --"

            color: Theme.foreground
            font.pixelSize: 13
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popup.visible = !popup.visible
        }
    }

    PopupWindow {
        id: popup

        anchor.item: button

        implicitWidth: 220
        implicitHeight: 110

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
                    margins: 14
                }

                spacing: 8

                Text {
                    text: "Battery"
                    color: Theme.foreground
                    font.bold: true
                }

                Text {
                    text: battery.ready
                        ? Math.round(battery.percentage) + "%"
                        : "Unknown"

                    color: Theme.foreground
                }

                Text {
                    text: UPower.onBattery
                        ? "Discharging"
                        : "Charging / plugged in"

                    color: Theme.foregroundDim
                }

                Text {
                    visible: battery.ready && battery.timeToEmpty > 0

                    text: {
                        const minutes = Math.round(battery.timeToEmpty / 60)
                        return "Remaining: " + Math.floor(minutes / 60)
                            + "h " + (minutes % 60) + "m"
                    }

                    color: Theme.foregroundDim
                }
            }
        }
    }
}
