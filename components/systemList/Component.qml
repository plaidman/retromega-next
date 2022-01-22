import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onLeftPressed: {
        event.accepted = true;
        systemScroll.systemsListView.decrementCurrentIndex();
    }

    Keys.onRightPressed: {
        event.accepted = true;
        systemScroll.systemsListView.incrementCurrentIndex();
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;

            currentGameIndex = 0;
            currentGame = currentCollection.games.get(0);
            currentView = 'gameList';
        }
    }

    SystemScroll {
        id: systemScroll;

        anchors {
            top: parent.top;
            bottom: collectionListFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: collectionListFooter;

        buttons: [
            { title: 'Select', key: 'A', square: false },
            { title: 'Menu', key: 'B', square: false },
        ];
    }

    Header.Component {
        showDivider: false;
        lightText: true;
    }
}
