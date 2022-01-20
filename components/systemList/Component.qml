import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors {
        fill: parent;
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;

            currentGame = 0;
            currentView = 'gameList';
        }
    }

    SystemScroll {
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
