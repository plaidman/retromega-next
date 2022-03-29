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
        currentView = 'gameList';
        sounds.forward();
    }

    function onSettingsPressed() {
        previousView = currentView;
        currentView = 'settings';
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
            { title: 'Select', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Menu', key: 'B', square: false, sigValue: null },
            { title: 'Settings', key: 'X', square: false, sigValue: 'settings' },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'settings') onSettingsPressed();
        }
    }

    Header.Component {
        showDivider: false;
        shade: 'light';
    }
}
