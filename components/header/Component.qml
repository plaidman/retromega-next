import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property string theme: 'light';
    property bool showCollection: false;

    color: 'transparent';
    height: root.height * .115;

    anchors {
        left: parent.left;
        right: parent.right;
        top: parent.top;
    }

    // divider
    Rectangle {
        height: 1;
        color: '#20000000';
        visible: showDivider;

        anchors {
            bottom: parent.bottom;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

    Text {
        visible: showCollection;
        text: currentCollection.name;
        color: collectionData.getColor(currentCollection.shortName);
        width: 300;
        elide: Text.ElideRight;

        anchors {
            left: parent.left;
            leftMargin: 32;
            verticalCenter: parent.verticalCenter;
        }

        font {
            pixelSize: parent.height * .33;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    Battery {
        id: battery;

        opacity: 0.5;
        theme: parent.theme;
        height: parent.height * .25;
        width: parent.height * .55;

        anchors {
            right: parent.right;
            rightMargin: parent.height * .36;
            verticalCenter: parent.verticalCenter;
        }
    }

    Clock {
        theme: parent.theme;

        height: parent.height;

        anchors {
            right: battery.left;
            rightMargin: parent.height * .30;
        }
    }
}
