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
        if (updated) {
            updateSortedCollection();
            sounds.nav();
            gameScroll.video.switchVideo();
        }
    }

    Keys.onRightPressed: {
        event.accepted = true;
        const updated = updateCollectionIndex(currentCollectionIndex + 1);
        if (updated) {
            updateSortedCollection();
            sounds.nav();
            gameScroll.video.switchVideo();
        }
    }

    function onAcceptPressed() {
        if (currentGameList.count === 0) return;

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
        const gameCount = currentGameList.count;
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
            const oldGame = getMappedGame(newIndex);
            const oldLetter = oldGame.sortBy[0].toLowerCase();

            while (newIndex > 0) {
                const newGame = getMappedGame(newIndex - 1);
                const newLetter = newGame.sortBy[0].toLowerCase();

                if (newLetter !== oldLetter) {
                    break;
                }

                newIndex--;
            }

            const updated = updateGameIndex(newIndex);
            if (updated) {
                gameScroll.letter = currentGame.title[0].toUpperCase();
                sounds.nav();
            }
        }

        // R1
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            if (currentGameIndex === currentGameList.count - 1) return;

            const oldLetter = currentGame.sortBy[0].toLowerCase();
            let newIndex = currentGameIndex;

            while (newIndex < currentGameList.count - 1) {
                newIndex++;
                const newGame = getMappedGame(newIndex);
                const newLetter = newGame.sortBy[0].toLowerCase();

                if (newLetter !== oldLetter) {
                    break;
                }
            }

            const updated = updateGameIndex(newIndex);
            if (updated) {
                gameScroll.letter = currentGame.title[0].toUpperCase();
                sounds.nav();
            }
        }
    }

	function onFavoritePressed() {
		if (currentGameList.count === 0 || onlyFavorites) return;
		
		currentGame.favorite = !currentGame.favorite;
		sounds.nav();
    }
	
    // todo keep an eye on this issue https://github.com/mmatyas/pegasus-frontend/issues/781
    // R2 and L2 must be handled 'onRelease' because of an android bug that requires double presses
    Keys.onReleased: {
        // R2
        if (api.keys.isPageDown(event)) {
            event.accepted = true;
            previousView = currentView;
            currentView = 'sorting';
            sounds.forward();
        }
		
		//L2
		if (api.keys.isPageUp(event)) {
            event.accepted = true;
            onFavoritePressed();
        }
    }

    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    GameScroll {
        id: gameScroll;

        letter: '';

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
        total: currentGameList.count;

        buttons: [
            { title: 'Play', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: 'Back', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
            { title: 'Details', key: theme.buttonGuide.details, square: false, sigValue: 'details' },
            { title: 'Random', key: theme.buttonGuide.filters, square: false, sigValue: 'filters' },
			{ title: 'Favorite', visible: !onlyFavorites, key: theme.buttonGuide.pageUp, square: true, sigValue: 'favorite' }
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'details') onDetailsPressed();
            if (sigValue === 'filters') onFiltersPressed();
			if (sigValue === 'favorite') onFavoritePressed();
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
