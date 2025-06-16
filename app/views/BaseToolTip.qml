import QtQuick
import QtQuick.Controls.Basic

ToolTip {
    id: tooltip

    delay: Theme.animationDuration * 5
    opacity: 0

    background: Rectangle {
        id: tooltipBackground

        radius: Theme.cornerRadius / 2
        color: Qt.lighter(Theme.colors.surface, 2)

        Canvas {
            id: triangle

            width: 12
            height: 6
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: -1

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.fillStyle = Qt.lighter(Theme.colors.surface, 2);
                ctx.beginPath();
                ctx.moveTo(width / 2, height);
                ctx.lineTo(0, 0);
                ctx.lineTo(width, 0);
                ctx.closePath();
                ctx.fill();
            }
        }
    }

    contentItem: Text {
        id: tooltipText

        text: tooltip.text
        font.pixelSize: Theme.fontSizeCaption
        color: Theme.colors.surfaceText
        padding: 0
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    onVisibleChanged: {
        if (tooltip.visible) {
            tooltip.opacity = 1;
            autoHideTimer.restart();
        } else {
            tooltip.opacity = 0;
            autoHideTimer.stop();
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Theme.animationDuration
            easing.type: Easing.InOutQuad
            onStopped: {
                if (tooltip.opacity === 0) {
                    tooltip.visible = false;
                }
            }
        }
    }

    Timer {
        id: autoHideTimer

        interval: Theme.animationDuration * 20
        repeat: false

        onTriggered: {
            tooltip.opacity = 0;
        }
    }
}
