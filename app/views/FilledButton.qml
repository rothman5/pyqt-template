import QtQuick

BaseButton {
    id: filledButton
    borderWidth: 0
    surfaceColor: filledButton.fillColor
    surfaceTextColor: filledButton.textColor
    iconColor: filledButton.textColor
    hoveredColor: Qt.darker(filledButton.fillColor, 1.2)
    pressedColor: Qt.darker(filledButton.fillColor, 1.4)

    property color fillColor: Theme.colors.primary
    property color textColor: Theme.colors.primaryText
}
