import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    function updateIndex(newIndex) {
        gameScroll.gamesListView.currentIndex = newIndex;
    }

    Keys.onUpPressed: {
        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex - 1);
        if (updated) { sounds.nav(); }
    }

    Keys.onDownPressed: {
        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex + 1);
        if (updated) { sounds.nav(); }
    }

    Keys.onLeftPressed: {
        event.accepted = true;
        const updated = updateCollectionIndex(currentCollectionIndex - 1);
        if (updated) { sounds.nav(); }
    }

    Keys.onRightPressed: {
        event.accepted = true;
        const updated = updateCollectionIndex(currentCollectionIndex + 1);
        if (updated) { sounds.nav(); }
    }

    function onAcceptPressed() {
        sounds.launch();
        currentGame.launch();
    }

    function onCancelPressed() {
        currentView = 'collectionList';
        updateGameIndex(0, true);
        sounds.back();
    }

    function onDetailsPressed() {
        currentView = 'gameDetails';
        sounds.forward();
    }

    function onFiltersPressed() {
        const gameCount = currentCollection.games.count;
        const randomIndex = Math.floor(Math.random() * gameCount);
        updateGameIndex(randomIndex);
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

        // L1
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            if (currentGameIndex === 0) return;

            let newIndex = currentGameIndex - 1;
            const oldGame = currentCollection.games.get(newIndex);
            const oldLetter = oldGame.title[0].toLowerCase();

            while (newIndex > 0) {
                const newGame = currentCollection.games.get(newIndex - 1);
                const newLetter = newGame.title[0].toLowerCase();

                if (newLetter !== oldLetter) {
                    break;
                }

                newIndex--;
            }

            const updated = updateGameIndex(newIndex);
            if (updated) { sounds.nav(); }
        }

        // R1
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            if (currentGameIndex === currentCollection.games.count - 1) return;

            const oldLetter = currentGame.title[0].toLowerCase();
            let newIndex = currentGameIndex;

            while (newIndex < currentCollection.games.count - 1) {
                newIndex++;
                const newGame = currentCollection.games.get(newIndex);
                const newLetter = newGame.title[0].toLowerCase();

                if (newLetter !== oldLetter) {
                    break;
                }
            }

            const updated = updateGameIndex(newIndex);
            if (updated) { sounds.nav(); }
        }

        // L2
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(currentCollectionIndex - 1);
            if (updated) { sounds.nav(); }
        }

        // R2
        if (api.keys.isPageDown(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(currentCollectionIndex + 1);
            if (updated) { sounds.nav(); }
        }
    }

    Rectangle {
        color: theme.current.bgColor;
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
            { title: 'Details', key: 'X', square: false, sigValue: 'details' },
            { title: 'Random', key: 'Y', square: false, sigValue: 'filters' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'details') onDetailsPressed();
            if (sigValue === 'filters') onFiltersPressed();
        }
    }

    Header.Component {
        id: gameListHeader;

        showDivider: true;
        shade: 'dark';
        color: theme.current.bgColor;
        showTitle: true;
    }
}
