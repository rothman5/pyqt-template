import QtQuick
import "../themes"


AbstractButton {
    id: success_filled_button
    label: qsTr("Success Filled Button")
    scale_animation: true
    text_color: Themes.current.text_secondary
    surface_color: Themes.current.success_primary
    disabled_color: Themes.current.success_primary
    border_color: Themes.current.success_primary
    hover_color: Themes.current.success_secondary
    hover_border_color: Themes.current.success_secondary
    pressed_color: Themes.current.success_secondary
    pressed_border_color: Themes.current.success_secondary
}
