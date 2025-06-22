import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    id: mainWindow
    title: "QML Template"
    visible: true
    minimumWidth: 480
    minimumHeight: 640
    width: mainWindow.minimumWidth
    height: mainWindow.minimumHeight
    color: Theme.colors.background

    DevicePanel {
        id: devicePanel
        anchors.margins: 8
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}
