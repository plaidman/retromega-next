import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    function updateIndex(newIndex) {
        collectionScroll.collectionListView.currentIndex = newIndex;
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
        currentGame = null;
        updateSortedCollection();
        currentView = 'gameList';
        sounds.forward();
    }

    function onSettingsPressed() {
        previousView = currentView;
        currentView = 'settings';
        sounds.forward();
    }

    function onAttractPressed() {
        currentView = 'attract';
        sounds.forward();
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onSettingsPressed();
        }

        // L1
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(0);
            if (updated) { sounds.nav(); }
        }

        // R1
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            const updated = updateCollectionIndex(allCollections.length - 1);
            if (updated) { sounds.nav(); }
        }
    }

    Keys.onReleased: {
        // L2
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            onAttractPressed();
        }

        // R2
        if (api.keys.isPageDown(event)) {
            event.accepted = true;
            previousView = currentView;
            currentView = 'sorting';
            sounds.forward();
        }
    }

    CollectionScroll {
        id: collectionScroll;

        anchors {
            top: parent.top;
            bottom: collectionListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: collectionListFooter;
        index: currentCollectionIndex + 1;
        total: allCollections.length;

        buttons: [
            { title: 'Select', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
            { title: 'Menu', key: theme.buttonGuide.cancel, square: false, sigValue: null },
            { title: 'Settings', key: theme.buttonGuide.details, square: false, sigValue: 'settings' },
            { title: 'Attract', key: theme.buttonGuide.pageUp, square: true, sigValue: 'attract' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'settings') onSettingsPressed();
            if (sigValue === 'attract') onAttractPressed();
        }
    }

    Header.Component {
        showDivider: false;
        shade: 'light';
    }
}
