import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

Item {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink

    implicitWidth: button.width
    implicitHeight: button.height

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    Rectangle {
        id: button

        implicitWidth: 70
        implicitHeight: 24
        radius: Theme.radius
        color: Theme.backgroundAlt

        Text {
            anchors.centerIn: parent

            text: {
                if (!root.sink?.audio)
                    return "󰖁 --"

                if (root.sink.audio.muted)
                    return "󰖁 Mute"

                return "󰕾 " + Math.round(root.sink.audio.volume * 100) + "%"
            }

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

        implicitWidth: 260
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

                spacing: 12

                Row {
                    width: parent.width
                    spacing: 10

                    Text {
                        text: root.sink?.description ?? "No output"
                        color: Theme.foreground

                        width: parent.width - 50
                        elide: Text.ElideRight
                    }

                    Text {
                        text: root.sink?.audio?.muted ? "󰖁" : "󰕾"
                        color: Theme.foreground
                    }
                }

                Slider {
                    width: parent.width

                    from: 0
                    to: 1
                    value: root.sink?.audio?.volume ?? 0

                    onMoved: {
                        if (root.sink?.audio)
                            root.sink.audio.volume = value
                    }
                }

                MouseArea {
                    width: parent.width
                    height: 20

                    onClicked: {
                        if (root.sink?.audio)
                            root.sink.audio.muted = !root.sink.audio.muted
                    }

                    Text {
                        anchors.centerIn: parent

                        text: root.sink?.audio?.muted
                            ? "Unmute"
                            : "Mute"

                        color: Theme.foregroundDim
                    }
                }
            }
        }
    }
}
