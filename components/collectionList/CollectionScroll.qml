import QtQuick 2.15

Item {
    property int collectionCount: api.collections.count;
    property alias collectionListView: collectionListView;

    Component.onCompleted: {
        collectionListView.currentIndex = currentCollectionIndex;
        collectionListView.positionViewAtIndex(currentCollectionIndex, ListView.Center);

        backgroundColor.color = collectionColor(currentCollection.shortName);
    }

    // background color, fades when collection changes
    Rectangle {
        id: backgroundColor;

        width: parent.width;
        height: parent.height;
        color: collectionColor(currentCollection.shortName);

        Behavior on color {
            ColorAnimation {
                duration: 335;
                easing.type: Easing.InOutQuad;
            }
        }
    }

    // dots
    PageIndicator {
        currentIndex: collectionListView.currentIndex;
        pageCount: collectionCount;

        anchors {
            horizontalCenter: parent.horizontalCenter;
            bottom: parent.bottom;
            bottomMargin: 25;
        }
    }

    ListView {
        id: collectionListView;

        model: api.collections;
        delegate: lvCollectionDelegate;
        orientation: ListView.Horizontal;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        preferredHighlightBegin: 0;
        preferredHighlightEnd: parent.width;
        snapMode: ListView.SnapToItem;
        highlightMoveDuration: 225;
        highlightMoveVelocity: -1;
        spacing: 50;
        anchors.fill: parent;

        onCurrentIndexChanged: {
            currentCollectionIndex = currentIndex;
            currentCollection = api.collections.get(currentIndex);

            backgroundColor.color = collectionColor(currentCollection.shortName);

            /* if (currentView === 'collectionList') sounds.nav(); */
        }
    }

    Component {
        id: lvCollectionDelegate;

        CollectionItem {
            width: collectionListView.width;
            height: collectionListView.height;
        }
    }
}
