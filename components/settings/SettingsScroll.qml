import QtQuick 2.15

Item {
    property alias settingsListView: settingsListView;
    property double itemHeight: {
        return settingsListView.height * .16;
    }

    Component.onCompleted: {
        settingsListView.currentIndex = 0;
        settingsListView.positionViewAtIndex(0, ListView.Center);
    }

    ListView {
        id: settingsListView;

        model: settings.keys;
        delegate: lvSettingsDelegate;
        width: parent.width - 40; // minus the margins
        height: parent.height - 24;
        highlightMoveDuration: 0;
        preferredHighlightBegin: itemHeight - 12; // height of an item minus top margin
        preferredHighlightEnd: parent.height - (itemHeight + 12); // height of an item plus bottom margin
        highlightRangeMode: ListView.ApplyRange;

        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
            right: parent.right;
            rightMargin: 20;
        }

        highlight: Rectangle {
            color: '#555555';
            radius: 8;
            width: setingsListView.width;
        }
    }

    Component {
        id: lvSettingsDelegate;

        SettingsItem {
            width: settingsListView.width;
            height: itemHeight;
        }
    }
}
