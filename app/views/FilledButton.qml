import QtQuick

BaseButton {
    id: filledButton

    property color fillColor: Theme.colors.primary
    property color textColor: Theme.colors.primaryText

    borderWidth: 0
    surfaceColor: filledButton.fillColor
    surfaceTextColor: filledButton.textColor
    hoveredColor: Qt.darker(filledButton.fillColor, 1.2)
    pressedColor: Qt.darker(filledButton.fillColor, 1.4)
}
