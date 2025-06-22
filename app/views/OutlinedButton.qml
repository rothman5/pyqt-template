import QtQuick

BaseButton {
    id: outlinedButton
    borderColor: outlinedButton.outlineColor
    hoveredBorderColor: Qt.darker(outlinedButton.outlineColor, 1.2)
    pressedBorderColor: Qt.darker(outlinedButton.outlineColor, 1.4)

    property color outlineColor: Theme.colors.primary
}
