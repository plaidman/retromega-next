import QtQuick 2.15

Rectangle {
    id: footer;

    property var buttons: [];
    property int index;
    property int total;

    signal buttonClicked(string sigValue);

    height: root.height * .115;
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
        spacing: parent.height * .27;

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

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        buttonClicked(modelData.sigValue);
                    }
                }
            }
        }
    }

    Text {
        text: index + ' of ' + total;
        color: '#9b9b9b';
        visible: total > 0;

        anchors {
            right: parent.right;
            rightMargin: 26;
            verticalCenter: parent.verticalCenter;
        }

        font {
            pixelSize: parent.height * .33;
            letterSpacing: -0.3;
            bold: true;
        }
    }
}
