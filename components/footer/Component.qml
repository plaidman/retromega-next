import QtQuick 2.15

Rectangle {
    id: footer;

    property var buttons: [];
    property int index;
    property int total;

    signal footerButtonClicked(string sigValue);

    height: root.height * .115 * theme.fontScale;
    color: theme.current.bgColor;

    anchors {
        left: parent.left;
        right: parent.right;
        bottom: parent.bottom;
    }

    // divider
    Rectangle {
        height: 1;
        color: theme.current.dividerColor;

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
                visible: modelData.visible ?? true;

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        footerButtonClicked(modelData.sigValue);
                    }
                }
            }
        }
    }

    Text {
        text: index + ' of ' + total;
        color: theme.current.footerCountColor;
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
