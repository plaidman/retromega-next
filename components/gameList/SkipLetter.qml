import QtQuick 2.15

Item {
    property var letter;
    property bool fade: false;

    width: letterRect.width;
    height: letterRect.height;

    onLetterChanged: {
        fade = false;
        letterRect.opacity = 1;
        fade = true;
        letterRect.opacity = 0;
    }

    Rectangle {
        id: letterRect;

        color: theme.current.bgColor;
        radius: 8;
        width: root.height * .4;
        height: root.height * .4;
        border.color: theme.current.blurTextColor;
        opacity: 0;

        Text {
            id: letterText;

            text: letter;
            color: theme.current.detailsColor;

            font {
                pixelSize: root.height * .2;
                bold: true;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                horizontalCenter: parent.horizontalCenter;
            }
        }

        Behavior on opacity {
            enabled: fade;
            PropertyAnimation { easing.type: Easing.InCubic; duration: 333; }
        }
    }
}
