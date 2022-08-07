import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer

Item {
    anchors.fill: parent;
    property bool fullDescriptionShowing: false;
    property bool favoritesChanged: false;

    function onCancelPressed() {
        if (favoritesChanged === true) {
            updateGameIndex(currentGameIndex, true);
            favoritesChanged = false;
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
        favoritesChanged = true;
        sounds.nav();
    }

    function onDetailsPressed() {
        if (!currentGame.description) return;

        fullDescriptionShowing = true;
        fullDescription.anchors.topMargin = 0;
        sounds.forward();
    }

    function hideFullDescription() {
        fullDescriptionShowing = false;
        fullDescription.anchors.topMargin = root.height;
        fullDescription.resetFlickable();
        sounds.back();
    }

    function detailsButtonClicked(button) {
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

            case 'less':
                hideFullDescription();
                break;
        }
    }

    Keys.onUpPressed: {
        if (fullDescriptionShowing) {
            fullDescription.scrollUp();
            return;
        }

        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex - 1);
        if (updated) {
            sounds.nav();
            allDetails.video.switchVideo();
        }
    }

    Keys.onDownPressed: {
        if (fullDescriptionShowing) {
            fullDescription.scrollDown();
            return;
        }

        event.accepted = true;
        const updated = updateGameIndex(currentGameIndex + 1);
        if (updated) {
            sounds.nav();
            allDetails.video.switchVideo();
        }
    }

    Keys.onPressed: {
        if (fullDescriptionShowing) {
            event.accepted = true;
            hideFullDescription();
            return;
        }

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
        id: allDetailsBlur;

        anchors.fill: parent;

        Rectangle {
            color: theme.current.bgColor;
            anchors.fill: parent;
        }

        AllDetails {
            id: allDetails;

            anchors {
                top: parent.top;
                bottom: detailsFooter.top;
                left: parent.left;
                right: parent.right;
            }
        }

        Footer.Component {
            id: detailsFooter;

            total: 0;

            buttons: [
                { title: 'Play', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: 'Back', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
                { title: 'More', key: theme.buttonGuide.details, square: false, sigValue: 'details' },
                { title: 'Favorite', key: theme.buttonGuide.filters, square: false, sigValue: 'filters' },
            ];

            onFooterButtonClicked: {
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
        blurSource: allDetailsBlur;

        anchors {
            top: parent.top;
            topMargin: root.height;
            left: parent.left;
            right: parent.right;
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
        }
    }
}
