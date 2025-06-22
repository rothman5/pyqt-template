import QtQuick

Rectangle {
    id: addedNotification
    width: notificationText.implicitWidth + 24
    height: 32
    radius: Theme.cornerRadius * 2
    color: addedNotification.fillColor
    opacity: 0
    visible: opacity > 0
    z: 100
    anchors.margins: 2
    anchors.bottomMargin: 12
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    property color fillColor: Qt.lighter(Theme.colors.surface, 4)
    property color textColor: Theme.colors.surface

    function showInfo(message) {
        addedNotification.fillColor = Qt.lighter(Theme.colors.surface, 4);
        addedNotification.textColor = Theme.colors.surface;
        showMessage(message);
    }

    function showError(message) {
        addedNotification.fillColor = Theme.colors.error;
        addedNotification.textColor = Theme.colors.errorText;
        showMessage(message);
    }

    function showMessage(message) {
        showAnimation.stop();
        fadeOutAnimation.stop();
        pauseTimer.stop();
        notificationText.text = message;
        showAnimation.from = addedNotification.opacity;
        showAnimation.start();
    }

    Text {
        id: notificationText
        font.pixelSize: Theme.fontSizeBody
        font.weight: Font.Medium
        color: addedNotification.textColor
        anchors.centerIn: parent
    }

    Timer {
        id: pauseTimer
        interval: Theme.animationDuration * 10
        onTriggered: fadeOutAnimation.start()
    }

    NumberAnimation {
        id: showAnimation
        target: addedNotification
        property: "opacity"
        from: 0
        to: 1
        duration: 200
        easing.type: Easing.OutQuad
        onFinished: pauseTimer.start()
    }

    NumberAnimation {
        id: fadeOutAnimation
        target: addedNotification
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InQuad
    }
}
