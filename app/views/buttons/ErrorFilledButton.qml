import QtQuick
import "../themes"


AbstractButton {
    id: error_filled_button
    label: qsTr("Error Filled Button")
    scale_animation: true
    text_color: Themes.current.text_secondary
    surface_color: Themes.current.error_primary
    disabled_color: Themes.current.error_primary
    border_color: Themes.current.error_primary
    hover_color: Themes.current.error_secondary
    hover_border_color: Themes.current.error_secondary
    pressed_color: Themes.current.error_secondary
    pressed_border_color: Themes.current.error_secondary
}
