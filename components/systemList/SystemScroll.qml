import QtQuick 2.15

Item {
    property int collectionCount: api.collections.count;
    property alias systemsListView: systemsListView;

    Component.onCompleted: {
        systemsListView.currentIndex = currentCollectionIndex;
        systemsListView.positionViewAtIndex(currentCollectionIndex, ListView.Center);

        backgroundColor.color = systemColor(currentCollection.shortName);
    }

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
        delegate: lvSystemDelegate;
        orientation: ListView.Horizontal;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        preferredHighlightBegin: 0;
        preferredHighlightEnd: parent.width;
        snapMode: ListView.SnapToItem;
        highlightMoveDuration: 225;
        highlightMoveVelocity: -1;
        spacing: 50;

        anchors {
            fill: parent;
        }

        onCurrentIndexChanged: {
            currentCollectionIndex = currentIndex;
            currentCollection = api.collections.get(currentIndex);
            backgroundColor.color = systemColor(currentCollection.shortName);
        }
    }

    Component {
        id: lvSystemDelegate;

        SystemItem {
            width: systemsListView.width;
            height: systemsListView.height;
        }
    }
}
