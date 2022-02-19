import QtQuick 2.15

Rectangle {
    property bool showDivider: true;
    property string shade: 'light';
    property bool showTitle: false;
    property string title: '';

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
        color: theme.current.dividerColor;
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
        visible: showTitle;
        text: title.length > 0
            ? title
            : currentCollection.name;
        color: title.length > 0
            ? theme.current.defaultHeaderNameColor
            : collectionData.getColor(currentCollection.shortName);
        opacity: theme.current.bgOpacity;
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

    Text {
        id: settingsIcon;

        text: glyphs.settings;
        opacity: 0.5;
        color: parent.shade === 'light'
            ? theme.current.settingsColorLight
            : theme.current.settingsColorDark;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .33;
        }

        anchors {
            right: parent.right;
            rightMargin: parent.height * .36;
            verticalCenter: parent.verticalCenter;
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (currentView === 'settings') return;

                previousView = currentView;
                currentView = 'settings';
                sounds.forward();
            }
        }
    }

    Battery {
        id: battery;

        opacity: 0.5;
        shade: parent.shade;
        height: parent.height * .25;
        width: parent.height * .55;

        anchors {
            right: settingsIcon.left;
            rightMargin: parent.height * .30;
            verticalCenter: parent.verticalCenter;
        }
    }

    Clock {
        shade: parent.shade;
        height: parent.height;
        opacity: 0.5;

        anchors {
            right: battery.left;
            rightMargin: parent.height * .30;
        }
    }
}
