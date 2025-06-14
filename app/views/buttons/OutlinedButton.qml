import QtQuick
import "../theme"

BaseButton {
    id: outlinedButton

    property color outlineColor: Theme.colors.primary

    hoveredBorderColor: outlinedButton.outlineColor
    pressedBorderColor: Qt.darker(outlinedButton.outlineColor, 1.2)
}
