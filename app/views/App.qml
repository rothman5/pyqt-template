import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "buttons"
import "themes"


ApplicationWindow {
    id: main_window
    visible: true
    width: 480
    height: 640
    title: qsTr("Style Tests")
    color: Themes.current.bg

    ColumnLayout {
        id: column_layout
        visible: true
        anchors.centerIn: parent

        NormalButton {
            id: button1
            label: "test1"
        }

        OutlinedButton {
            id: button2
            label: "test2"
        }

        FilledButton {
            id: button3
            label: "test3"
        }

        ErrorOutlinedButton {
            id: button4
            label: "test4"
        }

        ErrorFilledButton {
            id: button5
            label: "test5"
        }

        WarningOutlinedButton {
            id: button6
            label: "test6"
        }

        WarningFilledButton {
            id: button7
            label: "test7"
        }

        SuccessOutlinedButton {
            id: button8
            label: "test8"
        }

        SuccessFilledButton {
            id: button9
            label: "test9"
        }
    }
}
