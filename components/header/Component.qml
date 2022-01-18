import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property bool lightText: true;

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
        color: lightText ? '#20ffffff' : '#20000000';
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
        lightText: lightText;

        anchors {
            right: parent.right;
            rightMargin: 32;
            verticalCenter: parent.verticalCenter;
        }
    }

    Clock {
        lightText: lightText;

        anchors {
            right: battery.left;
            rightMargin: 12;
            verticalCenter: parent.verticalCenter;
        }
    }
}
