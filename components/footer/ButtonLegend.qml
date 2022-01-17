import QtQuick 2.12

Rectangle {
    property string title: 'Title';
    property string key: 'X';
    property bool square: false;

    anchors {
        verticalCenter: parent.verticalCenter;
    }

    Rectangle{
        height: 22;
        width: square ? 30 : 22;
        radius: square ? 8 : 22;
        color: '#444444';

        anchors {
            verticalCenter: parent.verticalCenter;
        }

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

        Text {
            text: title;
            color: '#70000000';

            font {
                pixelSize: 14;
                letterSpacing: -0.3;
                bold: true;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                left: parent.right;
                leftMargin: 4;
            }
        }
    }
}
