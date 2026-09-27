import Quickshell
import QtQuick

Text {
    text: Qt.formatDateTime(clock.date, "ddd dd MMM  HH:mm")

    color: Theme.foreground
    font.pixelSize: 13

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
