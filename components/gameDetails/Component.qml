import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    function onCancelPressed() {
        currentView = 'gameList';
        sounds.back();
    }

    function onAcceptPressed() {
        sounds.launch();
        currentGame.launch();
    }

    function onFiltersPressed() {
        currentGame.favorite = !currentGame.favorite;
        sounds.nav();
    }

    function onDetailsPressed() {
        /* currentGame.favorite = !currentGame.favorite; */
        /* sounds.forward(); */
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
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    // todo long description
    // todo touch functionality
    // todo controller functionality
    // todo smaller font
    AllDetails {
        anchors {
            top: parent.top;
            bottom: detailsFooter.top;
            left: parent.left;
            right: parent.right;
        }

        onButtonClicked: {
            switch (button) {
                case 'play':
                    onAcceptPressed();
                    break;

                case 'favorite':
                    onFiltersPressed();
                    break;

                case 'more':
                    // show details
                    break;
            }
        }
    }

    Footer.Component {
        id: detailsFooter;

        total: 0;

        buttons: [
            { title: 'Play', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
            { title: 'More', key: 'X', square: false, sigValue: 'details' },
            { title: 'Favorite', key: 'Y', square: false, sigValue: 'filters' },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
            if (sigValue === 'filters') onFiltersPressed();
            if (sigValue === 'details') onDetailsPressed();
        }
    }
}
