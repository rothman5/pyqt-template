import QtQuick
import "../themes"


AbstractButton {
    id: outlined_button
    label: qsTr("Outlined Button")
    hover_border_color: Themes.current.primary
    pressed_border_color: Themes.current.secondary
}
