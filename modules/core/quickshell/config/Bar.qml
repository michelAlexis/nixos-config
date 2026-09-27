import Quickshell
import QtQuick
import "widgets"

PanelWindow {
    id: root

    color: Theme.background

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Theme.barHeight
    exclusiveZone: Theme.barHeight

    Row {
        id: left

        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 8
        }

        spacing: Theme.spacing

        Workspaces {}
    }

    Clock {
        anchors.centerIn: parent
    }

    Row {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 8
        }

        spacing: Theme.spacing

        Battery {}
        Wifi {}
        Audio {}
        Power {}
    }
}
