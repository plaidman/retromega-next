import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;
    property bool fullDescriptionShowing: false;

    function onCancelPressed() {
        if (currentCollection.shortName === 'favorites') {
            updateGameIndex(currentGameIndex, true);
        }

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
        fullDescriptionShowing = !fullDescriptionShowing;

        if (fullDescriptionShowing) {
            fullDescription.anchors.topMargin = 0;
            fullDescription.resetFlickable();
            sounds.back();
        } else {
            fullDescription.anchors.topMargin = root.height;
            sounds.forward();
        }
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

    Item {
        id: allDetails;

        anchors.fill: parent;

        Rectangle {
            color: theme.current.bgColor;
            anchors.fill: parent;
        }

        // todo touch functionality
        //   enter details screen from game list
        //     tap image/video?
        //     hold game on game list?
        //   exit full description screen
        // todo controller functionality
        //   exit full description screen
        //   up/down scroll text
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
                        onDetailsPressed();
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

    GameDescription {
        id: fullDescription;

        height: parent.height;
        width: parent.width;
        blurSource: allDetails;

        anchors {
            top: parent.top;
            topMargin: root.height;
            left: parent.left;
            right: parent.right;
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200  }
        }
    }
}
