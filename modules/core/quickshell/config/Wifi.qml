import Quickshell
import Quickshell.Networking
import QtQuick

Item {
    id: root

    readonly property var wifi: {
        for (const device of Networking.devices.values) {
            if (device.type === DeviceType.Wifi)
                return device
        }

        return null
    }

    readonly property var connectedNetwork: {
        if (!wifi)
            return null

        for (const network of wifi.networks.values) {
            if (network.connected)
                return network
        }

        return null
    }

    implicitWidth: button.width
    implicitHeight: button.height

    Rectangle {
        id: button

        implicitWidth: 100
        implicitHeight: 24
        radius: Theme.radius
        color: Theme.backgroundAlt

        Text {
            anchors.centerIn: parent

            text: root.connectedNetwork
                ? "󰤨 " + root.connectedNetwork.name
                : "󰤭 Offline"

            color: Theme.foreground
            font.pixelSize: 13

            elide: Text.ElideRight
            width: parent.width - 12
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (popup.visible) {
                    popup.visible = false
                } else {
                    wifi.scannerEnabled = true
                    popup.visible = true
                }
            }
        }
    }

    PopupWindow {
        id: popup

        anchor.item: button

        implicitWidth: 280
        implicitHeight: Math.min(400, 80 + ((root.wifi?.networks.values.length ?? 0) * 38))

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

                spacing: 8

                Text {
                    text: root.wifi
                        ? "Wi-Fi"
                        : "Wi-Fi unavailable"

                    color: Theme.foreground
                    font.bold: true
                }

                Repeater {
                    model: root.wifi?.networks ?? []

                    delegate: Rectangle {
                        required property var modelData

                        width: parent.width
                        height: 30
                        radius: 4

                        color: modelData.connected
                            ? Theme.accent
                            : Theme.background

                        Text {
                            anchors {
                                left: parent.left
                                leftMargin: 8
                                verticalCenter: parent.verticalCenter
                            }

                            text: modelData.name
                            color: modelData.connected
                                ? Theme.background
                                : Theme.foreground

                            elide: Text.ElideRight
                            width: parent.width - 16
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                if (modelData.known)
                                    modelData.connect()

                                popup.visible = false
                            }
                        }
                    }
                }
            }
        }
    }
}
