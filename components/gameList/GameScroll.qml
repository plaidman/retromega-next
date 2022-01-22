import QtQuick 2.15

Item {
    property alias gamesListView: gamesListView;

    Component.onCompleted: {
        gamesListView.currentIndex = currentGameIndex
        gamesListView.positionViewAtIndex(currentGameIndex, ListView.Center);
    }

    ListView {
        id: gamesListView;

        model: currentCollection.games;
        delegate: lvGameDelegate;
        width: (parent.width / 2) - 20; // 20 is left margin
        height: parent.height;
        highlightMoveDuration: 0;
        keyNavigationWraps: true;
        preferredHighlightBegin: 30; // height of an item minus top margin
        preferredHighlightEnd: parent.height - 54; // height of an item plus top margin
        highlightRangeMode: ListView.ApplyRange;

        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
        }

        highlight: Rectangle {
            color: systemColor(currentCollection.shortName);
            radius: 8;
            width: gamesListView.width;
        }

        onCurrentIndexChanged: {
            currentGameIndex = currentIndex;
            currentGame = currentCollection.games.get(currentIndex);
        }
    }

    Component {
        id: lvGameDelegate;

        GameItem {
            width: gamesListView.width;
            height: 42;
        }
    }

    BoxArt {
        width: parent.width / 2;
        height: parent.height;
        x: parent.width / 2;
    }
}
