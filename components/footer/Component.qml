import QtQuick 2.15

Rectangle {
    property var buttons: [];

    height: 55;
    color: '#f3f3f3';

    anchors {
        left: parent.left;
        right: parent.right;
        bottom: parent.bottom;
    }

    // divider
    Rectangle {
        height: 1;
        color: '#20000000';

        anchors {
            top: parent.top;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

    // button guide
    Row {
        spacing: 15;

        anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 24;
        }

        Repeater {
            model: buttons;

            // each individual button
            ButtonLegend {
                title: modelData.title;
                key: modelData.key;
                square: modelData.square;
            }
        }
    }
}
