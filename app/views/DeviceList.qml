pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
    id: deviceList

    property var devModel: null
    property int desiredHeight: 240
    property int minHeight: Math.min(deviceListView.contentHeight, desiredHeight)
    property int maxHeight: desiredHeight

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: deviceList.minHeight
    Layout.maximumHeight: deviceList.maxHeight

    ListView {
        id: deviceListView

        anchors.fill: parent
        model: deviceList.devModel
        clip: true
        spacing: 4

        delegate: DeviceItem {
            id: deviceItem

            width: deviceListView.width

            required property int index
            required property string name
            required property var device
            required property bool connected

            deviceName: deviceItem.name
            deviceObject: deviceItem.device
            isConnected: deviceItem.connected

            onActionButtonClicked: {
                if (connected) {
                    console.log("Open configuration for device:", name);
                } else {
                    deviceListView.model.remove_device(index);
                }
            }
        }
    }

    // Bottom vignette effect to indicate more content below
    Rectangle {
        id: bottomVignette

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 24
        visible: deviceListView.contentHeight > deviceListView.height

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 1.0
                color: Theme.colors.background
            }
        }
    }

    // Top vignette when scrolled down
    Rectangle {
        id: topVignette

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 24
        visible: deviceListView.contentY > 0

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Theme.colors.background
            }
            GradientStop {
                position: 1.0
                color: "transparent"
            }
        }
    }
}
