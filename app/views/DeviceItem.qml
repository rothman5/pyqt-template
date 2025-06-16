import QtQuick
import QtQuick.Layouts

Item {
    id: deviceItem

    signal toggleConnection
    signal actionButtonClicked

    property string deviceName: ""
    property var deviceObject: null
    property bool isConnected: false
    property int padding: Theme.padding

    Layout.fillWidth: true
    height: deviceItemBackground.implicitHeight

    Rectangle {
        id: deviceItemBackground

        radius: Theme.cornerRadius
        border.width: Theme.borderWidth
        color: Qt.lighter(Theme.colors.surface, 1.2)
        border.color: Qt.lighter(Theme.colors.border, 1.2)
        anchors.fill: parent
        implicitHeight: deviceRowLayout.implicitHeight + deviceItem.padding * 2

        HoverHandler {
            id: deviceItemHoverHandler

            acceptedDevices: PointerDevice.AllDevices
            cursorShape: Qt.ArrowCursor

            onHoveredChanged: {
                deviceItemBackground.border.color = hovered ? Theme.colors.primary : Qt.lighter(Theme.colors.border, 1.2);
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        RowLayout {
            id: deviceRowLayout

            anchors.fill: parent
            anchors.margins: deviceItem.padding
            spacing: deviceItem.padding

            ColumnLayout {
                id: deviceInfoColumnLayout

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                spacing: 2

                Text {
                    id: deviceNameText

                    text: deviceItem.deviceName
                    font.bold: true
                    font.pointSize: Theme.fontSizeBody
                    color: Theme.colors.surfaceText
                }

                Text {
                    id: deviceStatusText

                    text: deviceItem.isConnected ? "Connected" : "Disconnected"
                    font.pointSize: Theme.fontSizeCaption
                    color: Theme.colors.disabledText
                }
            }

            RowLayout {
                id: deviceActionRowLayout

                spacing: deviceItem.padding
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                FilledButton {
                    id: actionButton

                    fillColor: Qt.lighter(Theme.colors.surface, 2)
                    textColor: Qt.lighter(Theme.colors.surfaceText, 2)
                    icon.source: deviceItem.isConnected ? "assets/configure.svg" : "assets/delete.svg"

                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32

                    BaseToolTip {
                        id: actionButtonToolTip

                        parent: actionButton
                        text: deviceItem.isConnected ? "Open configuration" : "Remove device"
                        visible: actionButton.hovered && !actionButton.pressed
                    }

                    onClicked: {
                        deviceItem.actionButtonClicked();
                    }
                }

                FilledButton {
                    id: toggleConnectionButton

                    fillColor: deviceItem.isConnected ? Theme.colors.error : Theme.colors.success
                    textColor: deviceItem.isConnected ? Theme.colors.errorText : Theme.colors.successText
                    icon.source: "assets/power.svg"

                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32

                    BaseToolTip {
                        id: toggleConnectionToolTip

                        parent: toggleConnectionButton
                        text: deviceItem.isConnected ? "Disconnect" : "Connect"
                        visible: toggleConnectionButton.hovered && !toggleConnectionButton.pressed
                    }

                    onClicked: {
                        deviceItem.toggleConnection();
                    }
                }
            }
        }
    }
}
