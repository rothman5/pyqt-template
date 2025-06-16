import QtQuick

QtObject {
    id: colorScheme

    required property color primary
    required property color primaryText
    required property color primaryVariant

    required property color secondary
    required property color secondaryText
    required property color secondaryVariant

    required property color textHint

    required property color border
    required property color borderFocused
    required property color borderHovered
    required property color borderPressed

    required property color focused
    required property color hovered
    required property color pressed

    required property color link
    required property color linkVisited

    required property color disabled
    required property color disabledText
    required property color surface
    required property color surfaceText
    required property color background
    required property color backgroundText

    required property color error
    required property color errorText
    required property color success
    required property color successText
    required property color warning
    required property color warningText
}
