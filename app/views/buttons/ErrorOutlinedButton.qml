import QtQuick
import "../themes"


AbstractButton {
    id: error_outlined_button
    label: qsTr("Error Outlined Button")
    hover_border_color: Themes.current.error_primary
    pressed_border_color: Themes.current.error_secondary
}
