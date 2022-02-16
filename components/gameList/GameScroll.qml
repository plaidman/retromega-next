import QtQuick 2.15

Item {
    property alias gamesListView: gamesListView;
    property double itemHeight: {
        return gamesListView.height * .12;
    }

    Component.onCompleted: {
        gamesListView.currentIndex = currentGameIndex;
        gamesListView.positionViewAtIndex(currentGameIndex, ListView.Center);
    }

    Text {
        visible: currentCollection.games.count === 0;
        text: 'No Games';
        anchors.centerIn: parent;
        color: '#80000000';

        font {
            family: globalFonts.sans;
            pixelSize: 18;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    ListView {
        id: gamesListView;

        model: currentCollection.games;
        delegate: lvGameDelegate;
        width: (parent.width / 2) - 20; // 20 is left margin
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
        }

        highlight: Rectangle {
            color: collectionData.getColor(currentCollection.shortName);
            radius: 8;
            width: gamesListView.width;
        }

        onCurrentIndexChanged: {
            currentGameIndex = currentIndex;
            currentGame = getMappedGame(currentIndex);
        }
    }

    Component {
        id: lvGameDelegate;

        GameItem {
            width: gamesListView.width;
            height: itemHeight;
        }
    }

    BoxArt {
        width: parent.width / 2;
        height: parent.height;
        x: parent.width / 2;
    }
}
