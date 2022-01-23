import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onLeftPressed: {
        event.accepted = true;
        collectionScroll.collectionListView.decrementCurrentIndex();
    }

    Keys.onRightPressed: {
        event.accepted = true;
        collectionScroll.collectionListView.incrementCurrentIndex();
    }

    function onAcceptPressed() {
        currentGameIndex = 0;
        currentGame = currentCollection.games.get(0);
        currentView = 'gameList';
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
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
        total: api.collections.count;

        buttons: [
            { title: 'Select', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Menu', key: 'B', square: false, sigValue: null },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') {
                onAcceptPressed();
            }
        }
    }

    Header.Component {
        showDivider: false;
        lightText: true;
    }
}
