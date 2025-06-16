import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ApplicationWindow {
    id: mainWindow
    title: "QML Template"
    visible: true
    minimumWidth: 480
    minimumHeight: 640
    width: mainWindow.minimumWidth
    height: mainWindow.minimumHeight
    color: Theme.colors.background

    ColumnLayout {
        id: columnLayout
        spacing: 4
        anchors.margins: 8
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.min(implicitHeight, parent.height / 2)

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
                var device_num = deviceModel.rowCount() + 1;
                var result = deviceModel.add_device("Device #" + device_num, "COM" + device_num, 115200);
            }
        }

        DeviceList {
            id: deviceList

            devModel: deviceModel
            desiredHeight: parent.parent.height / 2 - addDeviceButton.height - columnLayout.spacing - anchors.margins * 2
        }
    }
}
