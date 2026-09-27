import Quickshell
import "Bar"

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Bar {
            required property var modelData

            screen: modelData
        }
    }
}
