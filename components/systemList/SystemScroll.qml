import QtQuick 2.15

import '../resources' as Resources

Rectangle {
    property int collectionCount: api.collections.count;

    function systemColor(index) {
        const system = api.collections.get(index);
        const shortName = system.shortName ?? 'default';
        return systemData.systemColors[shortName] ?? systemData.systemColors['default'];
    }

    Component.onCompleted: {
        systemsListView.currentIndex = api.memory.get('systemIndex') ?? 0;
        systemsListView.positionViewAtIndex(systemsListView.currentIndex, ListView.Center);

        backgroundColor.color = systemColor(systemsListView.currentIndex);
    }

    Component.onDestruction: {
        api.memory.set('systemIndex', systemsListView.currentIndex);
    }

    Resources.SystemData { id: systemData; }

    // background color, fades when system changes
    Rectangle {
        id: backgroundColor;

        width: parent.width;
        height: parent.height;
        color: 'transparent';

        Behavior on color {
            ColorAnimation {
                duration: 335;
                easing.type: Easing.InOutQuad;
            }
        }
    }

    // dots
    PageIndicator {
        currentIndex: systemsListView.currentIndex;
        pageCount: collectionCount;

        anchors {
            horizontalCenter: parent.horizontalCenter;
            bottom: parent.bottom;
            bottomMargin: 25;
        }
    }

    ListView {
        id: systemsListView;

        model: api.collections;
        delegate: lvDelegate;
        cacheBuffer: 10;
        orientation: ListView.Horizontal;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        preferredHighlightBegin: 0;
        preferredHighlightEnd: parent.width;
        snapMode: ListView.SnapToItem;
        highlightMoveDuration: 225;
        highlightMoveVelocity: -1;
        spacing: 50;

        onCurrentIndexChanged: {
            backgroundColor.color = systemColor(currentIndex);
        }

        anchors {
            fill: parent;
        }
    }

    Component {
        id: lvDelegate;

        SystemItem {
            width: systemsListView.width;
            height: systemsListView.height;
        }
    }
}
