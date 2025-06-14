import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import "../theme"

Button {
    id: baseButton

    property bool scaleAnimation: true

    property color surfaceColor: Theme.colors.surface
    property color surfaceTextColor: Theme.colors.surfaceText
    property color hoveredColor: Theme.colors.hovered
    property color pressedColor: Theme.colors.pressed
    property color borderColor: Theme.colors.border
    property color hoveredBorderColor: Theme.colors.borderHovered
    property color pressedBorderColor: Theme.colors.borderPressed
    property color disabledColor: Theme.colors.disabled
    property color disabledTextColor: Theme.colors.disabledText

    property int lpadding: Theme.padding
    property int rpadding: Theme.padding
    property int tpadding: Theme.padding
    property int bpadding: Theme.padding
    property int borderWidth: Theme.borderWidth
    property int cornerRadius: Theme.cornerRadius

    property string iconSource: ""
    property int iconSize: 24
    property int iconPosition: Qt.LeftToRight
    property color iconColor: Qt.darker(baseButton.surfaceTextColor, 1.2)

    text: ""
    leftPadding: baseButton.lpadding
    rightPadding: baseButton.rpadding
    topPadding: baseButton.tpadding
    bottomPadding: baseButton.bpadding

    background: Rectangle {
        id: baseButtonBackground

        anchors.fill: parent
        radius: baseButton.cornerRadius
        border.width: baseButton.borderWidth
        color: baseButton.pressed ? baseButton.pressedColor : baseButton.hovered ? baseButton.hoveredColor : baseButton.surfaceColor
        border.color: baseButton.pressed ? baseButton.pressedBorderColor : baseButton.hovered ? baseButton.hoveredBorderColor : baseButton.borderColor

        Behavior on color {
            id: baseButtonBackgroundColorBehavior

            ColorAnimation {
                id: baseButtonBackgroundColorAnimation

                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on border.color {
            id: baseButtonBackgroundBorderColorBehavior

            ColorAnimation {
                id: baseButtonBackgroundBorderColorAnimation

                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    contentItem: Row {
        id: baseButtonContent

        anchors.centerIn: baseButtonBackground
        layoutDirection: baseButton.iconPosition

        ColorImage {
            id: baseButtonIcon

            height: Math.max(24, implicitHeight)
            visible: baseButton.iconSource !== ""
            source: baseButton.iconSource
            sourceSize: Qt.size(baseButton.iconSize, baseButton.iconSize)
            antialiasing: true
            anchors.verticalCenter: parent.verticalCenter
            color: !baseButton.enabled ? baseButton.disabledTextColor : baseButton.iconColor
        }

        Text {
            id: baseButtonText

            height: Math.max(24, implicitHeight)
            visible: baseButton.text !== ""
            text: baseButton.text
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSubTitle
            anchors.verticalCenter: baseButton.iconSource !== "" ? baseButtonIcon.verticalCenter : parent.verticalCenter
            color: !baseButton.enabled ? baseButton.disabledTextColor : baseButton.surfaceTextColor

            leftPadding: 4
            rightPadding: 4
            topPadding: 2
            bottomPadding: 2

            Behavior on color {
                id: baseButtonTextColorBehavior

                ColorAnimation {
                    id: baseButtonTextColorAnimation

                    duration: Theme.animationDuration
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    transform: Scale {
        id: baseButtonScale

        origin.x: baseButton.width / 2
        origin.y: baseButton.height / 2

        xScale: (baseButton.scaleAnimation && baseButton.pressed) ? 0.98 : 1
        yScale: (baseButton.scaleAnimation && baseButton.pressed) ? 0.98 : 1

        Behavior on xScale {
            id: baseButtonScaleXBehavior

            NumberAnimation {
                id: baseButtonScaleXAnimation

                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on yScale {
            id: baseButtonScaleYBehavior

            NumberAnimation {
                id: baseButtonScaleYAnimation

                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }
}
