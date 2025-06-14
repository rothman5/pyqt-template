import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "theme"
import "buttons"

ApplicationWindow {
    id: mainWindow

    title: "QML Template"
    visible: true
    minimumWidth: 480
    minimumHeight: 640
    width: mainWindow.minimumWidth
    height: mainWindow.minimumHeight
    color: Theme.colors.background

    RowLayout {
        id: buttonRowLayout

        anchors.centerIn: parent

        BaseButton {
            id: baseButtonText
            text: "Button"

            onClicked: {
                baseButtonText.loading = !baseButtonText.loading;
            }
        }

        // BaseButton {
        //     id: baseButtonIcon
        //     iconSource: "../assets/refresh.svg"
        // }

        // BaseButton {
        //     id: baseButton
        //     text: "Button"
        //     iconSource: "../assets/refresh.svg"
        // }

        // FilledButton {
        //     id: filledButtonText
        //     text: "Button"
        //     fillColor: Theme.colors.error
        //     textColor: Theme.colors.errorText
        // }

        // FilledButton {
        //     id: filledButtonIcon
        //     iconSource: "../assets/refresh.svg"
        // }

        // FilledButton {
        //     id: filledButton
        //     text: "Button"
        //     iconSource: "../assets/refresh.svg"
        // }

        // OutlinedButton {
        //     id: outlinedButtonText
        //     text: "Button"
        // }

        // OutlinedButton {
        //     id: outlinedButtonIcon
        //     iconSource: "../assets/refresh.svg"
        // }

        // OutlinedButton {
        //     id: outlinedButton
        //     text: "Button"
        //     iconSource: "../assets/refresh.svg"
        // }
    }
}
