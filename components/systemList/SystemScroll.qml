import QtQuick 2.15

import '../resources' as Resources

Rectangle {
    property int collectionCount: api.collections.count;

    function systemColor(shortName) {
        return systemData.systemColors[shortName] ?? systemData.systemColors['default'];
    }

    Component.onCompleted: {
        systemsListView.currentIndex = currentCollectionIndex;
        systemsListView.positionViewAtIndex(currentCollectionIndex, ListView.Center);

        backgroundColor.color = systemColor(currentCollection.shortName);
    }

    Resources.SystemData { id: systemData; }

    // background color, fades when system changes
    Rectangle {
        id: backgroundColor;

        width: parent.width;
        height: parent.height;
        color: systemColor(currentCollection.shortName);

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
            currentCollectionIndex = currentIndex;
            currentCollection = api.collections.get(currentIndex);
            backgroundColor.color = systemColor(currentCollection.shortName);
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
