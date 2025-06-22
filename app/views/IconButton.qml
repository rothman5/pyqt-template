import QtQuick

BaseButton {
    id: iconButton
    hover: false
    press: false
    borderWidth: 0
    surfaceColor: iconButton.bgColor
    iconSize: 16
    iconColor: (iconButton.hovered && !iconButton.pressed) ? iconButton.iconHoveredColor : iconButton.pressed ? iconButton.iconPressedColor : iconButton.fillColor

    property color bgColor: Theme.colors.surface
    property color fillColor: Theme.colors.surfaceText
    property color iconHoveredColor: Theme.colors.hovered
    property color iconPressedColor: Theme.colors.pressed
}
