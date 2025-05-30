import QtQuick
import "../themes"


AbstractButton {
    id: warning_outlined_button
    label: qsTr("Warning Outlined Button")
    hover_border_color: Themes.current.warning_primary
    pressed_border_color: Themes.current.warning_secondary
}
