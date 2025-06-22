import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Dialog {
    id: deviceDialog
    title: "Add a new serial device"
    modal: true
    width: 240
    x: (parent.parent.width / 2 - width / 2)
    y: -(parent.parent.y + parent.parent.height / 2)

    signal submitted(string name, string port, int baud)

    onAccepted: {
        var name = deviceNameInput.text.trim();
        var port = devicePortComboBox.currentText;
        var baud = deviceBaudComboBox.currentText;

        deviceDialog.submitted(name, port, parseInt(baud));
        deviceNameInput.clear();
        devicePortComboBox.currentIndex = 0;
        deviceBaudComboBox.currentIndex = 0;
    }

    onRejected: {
        deviceNameInput.clear();
        devicePortComboBox.currentIndex = 0;
        deviceBaudComboBox.currentIndex = 0;
    }

    background: Rectangle {
        id: dialogBackground
        radius: Theme.cornerRadius
        border.width: Theme.borderWidth
        color: Theme.colors.surface
        border.color: Theme.colors.border
    }

    contentItem: ColumnLayout {
        id: dialogLayout
        spacing: 0
        width: parent.width
        anchors.margins: 0
        anchors.fill: parent

        RowLayout {
            id: titleRow
            Layout.leftMargin: 8
            Layout.rightMargin: 2
            Layout.topMargin: 1
            Layout.bottomMargin: 0
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                id: dialogTitle
                text: deviceDialog.title
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeSubTitle
                font.bold: true
                font.italic: true
                color: Theme.colors.surfaceText
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            }

            IconButton {
                id: closeButton
                iconSource: "assets/close.svg"
                iconHoveredColor: Theme.colors.primary
                iconPressedColor: Qt.darker(Theme.colors.primary, 1.2)
                onClicked: deviceDialog.close()
            }
        }

        Rectangle {
            id: dialogSeparator
            color: Theme.colors.border
            opacity: 0.5
            Layout.fillWidth: true
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            Layout.topMargin: 0
            Layout.bottomMargin: 16
            Layout.preferredHeight: Theme.borderWidth
        }

        Text {
            id: deviceNameLabel
            text: "Name"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            font.bold: true
            color: Qt.darker(Theme.colors.surfaceText, 1.5)
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            Layout.alignment: Qt.AlignLeft
        }

        TextField {
            id: deviceNameInput
            maximumLength: 32
            placeholderText: "Enter a device name"
            placeholderTextColor: Theme.colors.border
            color: Theme.colors.surfaceText
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 4

            background: Rectangle {
                id: nameInputBackground
                radius: Theme.cornerRadius
                border.width: Theme.borderWidth
                color: Qt.lighter(Theme.colors.surface, 1.2)
                border.color: deviceNameInput.activeFocus ? Theme.colors.primary : Qt.lighter(Theme.colors.border, 1.2)

                Behavior on border.color {
                    ColorAnimation {
                        duration: Theme.animationDuration
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        Text {
            id: devicePortLabel
            text: "COM Port"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            font.bold: true
            color: Qt.darker(Theme.colors.surfaceText, 1.5)
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            Layout.alignment: Qt.AlignLeft
        }

        ComboBox {
            id: devicePortComboBox
            model: ["COM1", "COM2", "COM3", "COM4", "COM5"]
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 4
        }

        Text {
            id: deviceBaudLabel
            text: "Baudrate"
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            font.bold: true
            color: Qt.darker(Theme.colors.surfaceText, 1.5)
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            Layout.alignment: Qt.AlignLeft
        }

        ComboBox {
            id: deviceBaudComboBox
            model: ["9600", "38400", "115200", "460800", "921600"]
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 0
            Layout.bottomMargin: 0
        }

        RowLayout {
            id: buttonRow
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 16
            Layout.bottomMargin: 8
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            OutlinedButton {
                id: cancelButton
                text: "Cancel"
                outlineColor: Theme.colors.primary
                onClicked: deviceDialog.reject()
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                Layout.preferredWidth: dialogLayout.width / 2
            }

            FilledButton {
                id: addButton
                text: "Add"
                onClicked: deviceDialog.accept()
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: dialogLayout.width / 2
            }
        }
    }

    header: Rectangle {
        visible: false
    }

    footer: Rectangle {
        visible: false
    }
}
