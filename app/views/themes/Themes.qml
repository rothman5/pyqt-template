pragma Singleton
import QtQuick


QtObject {
    id: theme_manager

    readonly property AbstractTheme dark: DarkTheme {}
    readonly property AbstractTheme light: LightTheme {}

    property AbstractTheme current: dark

    function set_dark() {
        theme_manager.current = theme_manager.dark
    }

    function set_light() {
        theme_manager.current = theme_manager.light
    }
}