// qmllint disable unqualified
import QtQuick
import QtQuick.Layouts

Item {
    id: devicePanel
    height: Math.min(columnLayout.implicitHeight, parent.height / 2)

    DeviceDialog {
        id: deviceDialog
        onSubmitted: function (name, port, baud) {
            var result = deviceModel.add_device(name, port, baud);
            if (result) {
                addedNotification.showInfo("A new device has been added: " + name);
            } else {
                addedNotification.showError("Failed to add the device: " + name);
            }
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 4
        anchors.fill: parent

        BaseButton {
            id: addDeviceButton
            icon.source: "assets/plus.svg"

            Layout.fillWidth: true
            Layout.preferredHeight: 28

            BaseToolTip {
                id: addDeviceButtonToolTip
                parent: addDeviceButton
                text: "Add a new device"
                visible: addDeviceButton.hovered && !addDeviceButton.pressed
            }

            onClicked: {
                deviceDialog.open();
            }
        }

        DeviceList {
            id: deviceList
            visible: deviceList.nitems > 0
            devModel: deviceModel
            desiredHeight: devicePanel.parent.height / 2 - addDeviceButton.height - columnLayout.spacing - devicePanel.anchors.margins * 2
            Layout.fillWidth: true
        }

        Text {
            id: noDevicesText
            visible: deviceList.nitems === 0
            text: "No devices have been added."
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSubTitle
            color: Qt.lighter(Theme.colors.border, 2)
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 32
        }
    }

    Notification {
        id: addedNotification
    }
}
