import QtQuick
import "../themes"


AbstractButton {
    id: warning_filled_button
    label: qsTr("Warning Filled Button")
    scale_animation: true
    text_color: Themes.current.text_secondary
    surface_color: Themes.current.warning_primary
    disabled_color: Themes.current.warning_primary
    border_color: Themes.current.warning_primary
    hover_color: Themes.current.warning_secondary
    hover_border_color: Themes.current.warning_secondary
    pressed_color: Themes.current.warning_secondary
    pressed_border_color: Themes.current.warning_secondary
}
