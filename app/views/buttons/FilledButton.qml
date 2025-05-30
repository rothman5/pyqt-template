import QtQuick
import "../themes"


AbstractButton {
    id: filled_button
    label: qsTr("Filled Button")
    scale_animation: true
    text_color: Themes.current.text_secondary
    surface_color: Themes.current.primary
    disabled_color: Themes.current.primary
    border_color: Themes.current.primary
    hover_color: Themes.current.secondary
    hover_border_color: Themes.current.secondary
    pressed_color: Themes.current.secondary
    pressed_border_color: Themes.current.secondary
}
