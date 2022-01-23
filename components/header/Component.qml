import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property bool lightText: true;
    property bool showCollection: false;

    color: 'transparent';
    height: 55;

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

    Battery {
        id: battery;

        opacity: 0.5;
        lightText: parent.lightText;

        anchors {
            right: parent.right;
            rightMargin: 32;
            verticalCenter: parent.verticalCenter;
        }
    }

    Clock {
        lightText: parent.lightText;

        anchors {
            right: battery.left;
            rightMargin: 12;
            verticalCenter: parent.verticalCenter;
        }
    }

    Text {
        visible: showCollection;
        text: currentCollection.name;
        color: systemColor(currentCollection.shortName);
        width: 300;
        elide: Text.ElideRight;

        anchors {
            left: parent.left;
            leftMargin: 32
            verticalCenter: parent.verticalCenter
        }

        font {
            pixelSize: 18
            letterSpacing: -0.3
            bold: true
        }
    }
}
