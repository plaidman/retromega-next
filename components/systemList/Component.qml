import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors {
        fill: parent;
    }

    focus: true;
    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            debug.text = 'pressed';

            event.accepted = true;

            currentGame = 0;
            currentView = 'gameList';
        }
    }

    SystemScroll {
        anchors {
            top: parent.top;
            bottom: footer.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: footer;

        buttons: [
            { title: 'Select', key: 'A', square: false },
            { title: 'Menu', key: 'B', square: false },
        ];
    }

    Header.Component {
        id: header;
        showDivider: false;
    }
}
