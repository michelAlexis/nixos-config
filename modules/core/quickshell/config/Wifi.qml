import Quickshell
import Quickshell.Networking
import QtQuick
import QtQml
import QtQuick.Controls

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

    // Networks sorted: connected first, then by signal strength.
    readonly property var sortedNetworks: {
        if (!wifi)
            return []

        const list = wifi.networks.values.slice()
        list.sort((a, b) => {
            if (a.connected !== b.connected)
                return a.connected ? -1 : 1
            return b.signalStrength - a.signalStrength
        })
        return list
    }

    // Network currently being configured (password prompt).
    property var pending: null
    property string errorText: ""

    function isSecured(network) {
        return network.security !== WifiSecurityType.Open
            && network.security !== WifiSecurityType.Owe
    }

    function isEnterprise(network) {
        return network.security === WifiSecurityType.Wpa2Eap
            || network.security === WifiSecurityType.WpaEap
            || network.security === WifiSecurityType.Leap
    }

    function select(network) {
        errorText = ""

        if (network.connected)
            return

        if (network.known || !isSecured(network)) {
            network.connect()
            pending = null
            return
        }

        userField.text = ""
        passField.text = ""
        pending = network
    }

    function submit() {
        const network = pending
        if (!network)
            return

        errorText = ""

        if (isEnterprise(network)) {
            // 802.1x networks need a profile with identity + password.
            const ssid = network.name
            const script = 'nmcli connection delete id "$1" >/dev/null 2>&1; '
                + 'nmcli connection add type wifi con-name "$1" ssid "$1" '
                + 'wifi-sec.key-mgmt wpa-eap 802-1x.eap peap '
                + '802-1x.phase2-auth mschapv2 '
                + '802-1x.identity "$2" 802-1x.password "$3" && '
                + 'nmcli connection up id "$1"'
            Quickshell.execDetached(["sh", "-c", script, "sh", ssid, userField.text, passField.text])
        } else {
            network.connectWithPsk(passField.text)
        }

        pending = null
        passField.text = ""
    }

    function strengthLevel(strength) {
        // 0..4 bars
        if (strength <= 0)
            return 0
        return Math.min(4, Math.max(1, Math.ceil(strength * 4)))
    }

    implicitWidth: button.width
    implicitHeight: button.height

    // Signal bars: 4 vertical bars of increasing height.
    component SignalBars: Row {
        id: bars

        property real strength: 0
        property color activeColor: Theme.foreground
        property color inactiveColor: Theme.foregroundDim
        readonly property int level: root.strengthLevel(strength)

        spacing: 2
        height: 14

        Repeater {
            model: 4

            Rectangle {
                required property int index

                width: 3
                height: 4 + index * 3
                y: bars.height - height
                radius: 1
                color: index < bars.level ? bars.activeColor : bars.inactiveColor
                opacity: index < bars.level ? 1 : 0.35
            }
        }
    }

    Rectangle {
        id: button

        implicitWidth: 40
        implicitHeight: 24
        radius: Theme.radius
        color: Theme.backgroundAlt

        Row {
            anchors.centerIn: parent
            spacing: 5

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: !root.connectedNetwork
                text: "󰤭"
                color: Theme.foreground
                font.pixelSize: 13
            }

            SignalBars {
                anchors.verticalCenter: parent.verticalCenter
                visible: !!root.connectedNetwork
                strength: root.connectedNetwork?.signalStrength ?? 0
            }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (popup.visible) {
                    popup.visible = false
                } else {
                    if (root.wifi)
                        root.wifi.scannerEnabled = true
                    root.pending = null
                    root.errorText = ""
                    popup.visible = true
                }
            }
        }
    }

    PopupWindow {
        id: popup

        anchor.item: button
        // Align popup under the bar, separated by Theme.popupGap
        anchor.rect.y: button.height + (Theme.barHeight - button.height) / 2 + Theme.popupGap

        implicitWidth: 300
        implicitHeight: content.implicitHeight + 24

        visible: false
        color: "transparent"
        grabFocus: true

        onVisibleChanged: {
            if (!visible && root.wifi)
                root.wifi.scannerEnabled = false
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.backgroundAlt
            radius: Theme.radius

            Column {
                id: content

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 12
                }

                spacing: 8

                Text {
                    text: root.wifi ? "Wi-Fi" : "Wi-Fi unavailable"
                    color: Theme.foreground
                    font.bold: true
                }

                ListView {
                    id: list

                    width: parent.width
                    height: Math.min(260, contentHeight)
                    clip: true
                    spacing: 4
                    interactive: contentHeight > height

                    model: root.sortedNetworks

                    delegate: Rectangle {
                        id: row

                        required property var modelData

                        readonly property bool selected: root.pending === modelData

                        width: ListView.view.width
                        height: 30
                        radius: 4

                        color: modelData.connected
                            ? Theme.accent
                            : (hover.containsMouse || selected ? Theme.backgroundAlt : Theme.background)
                        border.width: selected ? 1 : 0
                        border.color: Theme.accent

                        SignalBars {
                            id: rowBars

                            anchors {
                                left: parent.left
                                leftMargin: 8
                                verticalCenter: parent.verticalCenter
                            }

                            strength: row.modelData.signalStrength
                            activeColor: row.modelData.connected ? Theme.background : Theme.foreground
                            inactiveColor: row.modelData.connected ? Theme.background : Theme.foregroundDim
                        }

                        Text {
                            anchors {
                                left: rowBars.right
                                leftMargin: 8
                                right: lock.left
                                rightMargin: 6
                                verticalCenter: parent.verticalCenter
                            }

                            text: row.modelData.name
                            color: row.modelData.connected ? Theme.background : Theme.foreground
                            elide: Text.ElideRight
                        }

                        Text {
                            id: lock

                            anchors {
                                right: parent.right
                                rightMargin: 8
                                verticalCenter: parent.verticalCenter
                            }

                            text: row.modelData.connected
                                ? "connected"
                                : (root.isSecured(row.modelData) ? "󰌾" : "")
                            color: row.modelData.connected ? Theme.background : Theme.foregroundDim
                            font.pixelSize: row.modelData.connected ? 11 : 13
                        }

                        MouseArea {
                            id: hover

                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: root.select(row.modelData)
                        }
                    }
                }

                // Password / credentials prompt for new secured networks.
                Column {
                    visible: root.pending !== null
                    width: parent.width
                    spacing: 6

                    Text {
                        width: parent.width
                        text: "Connect to " + (root.pending?.name ?? "")
                        color: Theme.foreground
                        elide: Text.ElideRight
                    }

                    TextField {
                        id: userField

                        visible: root.pending !== null && root.isEnterprise(root.pending)
                        width: parent.width
                        placeholderText: "Username"
                        color: Theme.foreground
                        selectByMouse: true
                        onAccepted: passField.forceActiveFocus()

                        background: Rectangle {
                            radius: 4
                            color: Theme.background
                            border.width: 1
                            border.color: userField.activeFocus ? Theme.accent : Theme.backgroundAlt
                        }
                    }

                    TextField {
                        id: passField

                        width: parent.width
                        placeholderText: "Password"
                        echoMode: TextInput.Password
                        color: Theme.foreground
                        selectByMouse: true
                        onAccepted: root.submit()

                        background: Rectangle {
                            radius: 4
                            color: Theme.background
                            border.width: 1
                            border.color: passField.activeFocus ? Theme.accent : Theme.backgroundAlt
                        }
                    }

                    Row {
                        spacing: 6

                        Rectangle {
                            width: 90
                            height: 28
                            radius: 4
                            color: Theme.accent

                            Text {
                                anchors.centerIn: parent
                                text: "Connect"
                                color: Theme.background
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: root.submit()
                            }
                        }

                        Rectangle {
                            width: 90
                            height: 28
                            radius: 4
                            color: Theme.background

                            Text {
                                anchors.centerIn: parent
                                text: "Cancel"
                                color: Theme.foreground
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: root.pending = null
                            }
                        }
                    }
                }

                Text {
                    visible: root.errorText !== ""
                    width: parent.width
                    text: root.errorText
                    color: Theme.danger
                    wrapMode: Text.Wrap
                }
            }
        }
    }

    // Surface connection failures (e.g. wrong password).
    Instantiator {
        model: root.sortedNetworks

        delegate: QtObject {
            required property var modelData

            property var conn: Connections {
                target: modelData
                ignoreUnknownSignals: true

                function onConnectionFailed(reason) {
                    root.errorText = "Failed: " + ConnectionFailReason.toString(reason)
                    popup.visible = true
                }
            }
        }
    }
}
