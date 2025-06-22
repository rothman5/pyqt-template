pragma Singleton
import QtQuick

QtObject {
    id: theme

    property bool darkMode: true
    property string fontFamily: "Segoe UI"
    property int fontSizeCaption: 10
    property int fontSizeBody: 12
    property int fontSizeSubTitle: 14
    property int fontSizeTitle: 18
    property int padding: 8
    property int borderWidth: 1
    property int cornerRadius: 8
    property int animationDuration: 200

    property ColorScheme colors: ColorScheme {
        primary: theme.darkMode ? "#EBCB8B" : "#EBCB8B"
        primaryText: theme.darkMode ? "#262424" : "#262424"
        primaryVariant: theme.darkMode ? "#D08770" : "#D08770"
        secondary: theme.darkMode ? "#81A1C1" : "#81A1C1"
        secondaryText: theme.darkMode ? "#262424" : "#262424"
        secondaryVariant: theme.darkMode ? "#5E81AC" : "#5E81AC"
        textHint: theme.darkMode ? "#434C5E" : "#434C5E"
        border: theme.darkMode ? "#4a4a46" : "#4a4a46"
        borderFocused: theme.darkMode ? "#EBCB8B" : "#EBCB8B"
        borderHovered: theme.darkMode ? Qt.darker("#4a4a46", 1.2) : Qt.darker("#4a4a46", 1.2)
        borderPressed: theme.darkMode ? Qt.darker("#4a4a46", 1.4) : Qt.darker("#4a4a46", 1.4)
        focused: theme.darkMode ? Qt.lighter("#302f2f", 1.2) : Qt.lighter("#302f2f", 1.2)
        hovered: theme.darkMode ? Qt.darker("#302f2f", 1.2) : Qt.darker("#302f2f", 1.2)
        pressed: theme.darkMode ? Qt.darker("#302f2f", 1.4) : Qt.darker("#302f2f", 1.4)
        link: theme.darkMode ? "#88C0D0" : "#88C0D0"
        linkVisited: theme.darkMode ? "#81A1C1" : "#81A1C1"
        disabled: theme.darkMode ? Qt.darker("#302f2f", 1.5) : Qt.darker("#302f2f", 1.5)
        disabledText: theme.darkMode ? Qt.darker("#D8DEE9", 1.5) : Qt.darker("#D8DEE9", 1.5)
        surface: theme.darkMode ? "#302f2f" : "#302f2f"
        surfaceText: theme.darkMode ? "#D8DEE9" : "#D8DEE9"
        background: theme.darkMode ? "#262424" : "#262424"
        backgroundText: theme.darkMode ? "#D8DEE9" : "#D8DEE9"
        error: theme.darkMode ? "#BF616A" : "#BF616A"
        errorText: theme.darkMode ? "#262424" : "#262424"
        success: theme.darkMode ? "#A3BE8C" : "#A3BE8C"
        successText: theme.darkMode ? "#262424" : "#262424"
        warning: theme.darkMode ? "#D08770" : "#D08770"
        warningText: theme.darkMode ? "#262424" : "#262424"
    }
}
