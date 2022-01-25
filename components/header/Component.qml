import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property string theme: 'light';
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

    Text {
        visible: showCollection;
        text: currentCollection.name;
        color: collectionColor(currentCollection.shortName);
        width: 300;
        elide: Text.ElideRight;

        anchors {
            left: parent.left;
            leftMargin: 32;
            verticalCenter: parent.verticalCenter;
        }

        font {
            pixelSize: 18;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    MusicIcon {
        id: musicIcon;
        theme: parent.theme;

        anchors {
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 20;
        }
    }

    Battery {
        id: battery;

        opacity: 0.5;
        theme: parent.theme;

        anchors {
            right: musicIcon.left;
            rightMargin: 12;
            verticalCenter: parent.verticalCenter;
        }
    }

    Clock {
        theme: parent.theme;

        anchors {
            right: battery.left;
            rightMargin: 12;
            verticalCenter: parent.verticalCenter;
        }
    }
}
