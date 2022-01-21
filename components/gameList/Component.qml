import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Rectangle {
    color: 'magenta';

    anchors {
        fill: parent;
    }

    Footer.Component {
        id: gameListFooter;

        buttons: [
            { title: 'Select', key: 'A', square: false },
            { title: 'Back', key: 'B', square: false },
        ];
    }

    Header.Component {
        id: gameListHeader;

        showDivider: true;
        lightText: false;
    }

    Text {
        anchors {
            top: gameListHeader.bottom;
            bottom: gameListHeader.top;
            left: parent.left;
            right: parent.right;
        }

        text: 'game list ' + currentCollection.shortName;
        color: '#000000';
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            currentView = 'systemList';
        }
    }
}
