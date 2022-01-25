import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onUpPressed: {
        event.accepted = true;
        gameScroll.gamesListView.decrementCurrentIndex();
        sounds.nav();
    }

    Keys.onDownPressed: {
        event.accepted = true;
        gameScroll.gamesListView.incrementCurrentIndex();
        sounds.nav();
    }

    function onAcceptPressed() {
        sounds.launch();
        // debug
        /* currentGame.launch(); */
        debug.text = currentGame.title;
    }

    function onCancelPressed() {
        currentView = 'collectionList';
        gameScroll.gamesListView.currentIndex = 0;
        sounds.back();
    }

    function onDetailsPressed() {
        currentGame.favorite = !currentGame.favorite;
    }

    function onFiltersPressed() {
        const gameCount = currentCollection.games.count;
        const randomIndex = Math.floor(Math.random() * gameCount);
        gameScroll.gamesListView.currentIndex = randomIndex;
        sounds.nav();
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onDetailsPressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            onFiltersPressed();
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
            { title: 'Play', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
            { title: 'Favorite', key: 'X', square: false, sigValue: 'favorite' },
            { title: 'Random', key: 'Y', square: false, sigValue: 'random' },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'favorite') onDetailsPressed();
            if (sigValue === 'random') onFiltersPressed();
        }
    }

    Header.Component {
        id: gameListHeader;

        showDivider: true;
        theme: 'dark';
        color: '#f3f3f3';
        showCollection: true;
    }
}
