import QtQuick
import QtQuick.Controls.Basic

Button {
    id: button
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeSubTitle
    palette.buttonText: button.surfaceTextColor
    icon.source: button.iconSource
    icon.width: button.iconSize
    icon.height: button.iconSize
    icon.color: Qt.darker(button.iconColor, 1.2)

    property bool scale: true
    property bool hover: true
    property bool press: true
    property string iconSource: ""
    property int iconSize: 24
    property color iconColor: Theme.colors.surfaceText
    property int borderWidth: Theme.borderWidth
    property int cornerRadius: Theme.cornerRadius
    property color surfaceColor: Theme.colors.surface
    property color surfaceTextColor: Theme.colors.surfaceText
    property color hoveredColor: Theme.colors.hovered
    property color pressedColor: Theme.colors.pressed
    property color borderColor: Theme.colors.border
    property color hoveredBorderColor: Theme.colors.borderHovered
    property color pressedBorderColor: Theme.colors.borderPressed
    property color disabledColor: Theme.colors.disabled
    property color disabledTextColor: Theme.colors.disabledText

    background: Rectangle {
        id: buttonBackground
        anchors.fill: parent
        radius: button.cornerRadius
        border.width: button.borderWidth
        color: (button.pressed && button.press) ? button.pressedColor : (button.hovered && button.hover) ? button.hoveredColor : button.surfaceColor
        border.color: (button.pressed && button.press) ? button.pressedBorderColor : (button.hovered && button.hover) ? button.hoveredBorderColor : button.borderColor

        Behavior on color {
            ColorAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    transform: Scale {
        id: buttonScale
        origin.x: button.width / 2
        origin.y: button.height / 2
        xScale: (button.scale && button.pressed) ? 0.98 : 1
        yScale: (button.scale && button.pressed) ? 0.98 : 1

        Behavior on xScale {
            NumberAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on yScale {
            NumberAnimation {
                duration: Theme.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    Behavior on icon.color {
        ColorAnimation {
            duration: Theme.animationDuration
            easing.type: Easing.InOutQuad
        }
    }
}
