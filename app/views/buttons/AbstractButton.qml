import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../themes"


Button {
    id: abstract_button
    Layout.fillWidth: true

    property alias label: button_text.text
    property bool scale_animation: false
    property int transition_duration: 150

    property color text_color: Themes.current.text_primary
    property color text_disabled_color: Themes.current.text_disabled
    property color surface_color: Themes.current.surface
    property color disabled_color: Themes.current.surface
    property color pressed_color: Themes.current.pressed_bg
    property color hover_color: Themes.current.hover_bg
    property color border_color: Themes.current.border
    property color pressed_border_color: Themes.current.pressed_border
    property color hover_border_color: Themes.current.hover_border

    contentItem: Text {
        id: button_text
        color: abstract_button.enabled ? abstract_button.text_color : abstract_button.text_disabled_color
        font.pixelSize: 14
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: button_background
        radius: 8

        color: !abstract_button.enabled ? abstract_button.disabled_color :
               abstract_button.pressed  ? abstract_button.pressed_color  :
               abstract_button.hovered  ? abstract_button.hover_color    :
               abstract_button.surface_color

        border.width: 1
        border.color: abstract_button.pressed ? abstract_button.pressed_border_color :
                      abstract_button.hovered ? abstract_button.hover_border_color   :
                      abstract_button.border_color

        Behavior on color {
            ColorAnimation {
                easing.type: Easing.InOutQuad
                duration: abstract_button.transition_duration
            }
        }

        Behavior on border.color {
            ColorAnimation {
                easing.type: Easing.InOutQuad
                duration: abstract_button.transition_duration
            }
        }

        transform: Scale {
            id: scale_transform
            origin.x: button_background.width / 2
            origin.y: button_background.height / 2
            xScale: 1.0
            yScale: 1.0
        }

        states: State {
            name: "pressed_scaled"
            when: abstract_button.scale_animation && abstract_button.pressed
            PropertyChanges {
                target: scale_transform
                xScale: 0.96
                yScale: 0.96
            }
        }

        transitions: Transition {
            from: ""
            to: "pressed_scaled"
            reversible: true
            NumberAnimation {
                properties: "xScale, yScale"
                duration: abstract_button.transition_duration
                easing.type: Easing.InOutQuad
            }
        }
    }
}
