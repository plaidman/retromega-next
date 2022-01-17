import QtQuick 2.15

Rectangle {
    property string key: 'X';
    property string title: 'Title';
    property bool square: false;

    height: 22;
    width: icon.width + outerText.width + 4;
    color: 'transparent';

    // button background
    Rectangle {
        id: icon;

        height: 22;
        width: square ? 30 : 22;
        radius: square ? 6 : 22;
        color: '#444444';

        anchors {
            verticalCenter: parent.verticalCenter;
        }

        // button inner text
        Text {
            text: key;
            color: '#ffffff';

            font {
                pixelSize: 14;
                letterSpacing: -0.3;
                bold: true;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                horizontalCenter: parent.horizontalCenter;
            }
        }
    }

    // button outer text
    Text {
        id: outerText;

        text: title;
        color: '#70000000';

        font {
            pixelSize: 14;
            letterSpacing: -0.3;
            bold: true;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            left: icon.right;
            leftMargin: 4;
        }
    }
}
