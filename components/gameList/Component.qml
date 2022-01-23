import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onUpPressed: {
        event.accepted = true;
        gameScroll.gamesListView.decrementCurrentIndex();
    }

    Keys.onDownPressed: {
        event.accepted = true;
        gameScroll.gamesListView.incrementCurrentIndex();
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            currentView = 'systemList';
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            currentGame.launch();
        }
    }

    Rectangle {
        color: '#f3f3f3';
        anchors.fill: parent;
    }

    GameScroll {
        id: gameScroll;

        anchors {
            top: gameListHeader.bottom;
            bottom: gameListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: gameListFooter;
        index: currentGameIndex + 1;
        total: currentCollection.games.count;

        buttons: [
            { title: 'Play', key: 'A', square: false },
            { title: 'Back', key: 'B', square: false },
        ];
    }

    Header.Component {
        id: gameListHeader;

        showDivider: true;
        lightText: false;
        color: '#f3f3f3';
        showCollection: true;
    }
}
