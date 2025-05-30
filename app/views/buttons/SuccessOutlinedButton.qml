import QtQuick
import "../themes"


AbstractButton {
    id: success_outlined_button
    label: qsTr("Success Outlined Button")
    hover_border_color: Themes.current.success_primary
    pressed_border_color: Themes.current.success_secondary
}
