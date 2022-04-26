import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    // todo put this in a different file

    function updateSort(key, defaultSort) {
        return () => {
            if (sortKey !== key) {
                sortKey = key;
                sortOrder = defaultSort;
                return;
            }

            if (sortOrder === Qt.AscendingOrder) {
                sortOrder = Qt.DescendingOrder;
                return;
            }

            sortOrder = Qt.AscendingOrder;
        }
    }

    ListModel {
        id: sortingModel;

        ListElement {
            key: 'sortBy';
            title: 'Title';
            type: 'alpha';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'lastPlayed';
            title: 'Last Played';
            type: 'numeric';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'rating';
            title: 'Rating';
            type: 'numeric';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'release';
            title: 'Release Date';
            type: 'numeric';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'onlyFavorites';
            title: 'Only Favorites';
            type: 'onlyFavorites';
            defaultOrder: 'enabled';
        }
    }

    function executeCallback(key) {
        const callbacks = {
            sortBy: updateSort('sortBy', Qt.AscendingOrder),
            lastPlayed: updateSort('lastPlayed', Qt.DescendingOrder),
            rating: updateSort('rating', Qt.DescendingOrder),
            release: updateSort('release', Qt.AscendingOrder),
            onlyFavorites: () => { onlyFavorites = !onlyFavorites; },
        };

        callbacks[key]();
    }

    Keys.onUpPressed: {
        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.decrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    Keys.onDownPressed: {
        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.incrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    function onAcceptPressed() {
        const currentKey = sortingModel.get(sortingScroll.sortingListView.currentIndex).key;
        executeCallback(currentKey);
        sounds.nav();
    }

    function onCancelPressed() {
        currentView = previousView;
        sounds.back();
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
    }

    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    SortingScroll {
        id: sortingScroll;

        anchors {
            top: sortingHeader.bottom;
            bottom: sortingFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: sortingFooter;

        total: 0;

        buttons: [
            { title: 'Toggle', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
        }
    }

    Header.Component {
        id: sortingHeader;

        showDivider: true;
        shade: 'dark';
        color: theme.current.bgColor;
        showTitle: true;
        title: 'Sorting and Filters';
    }
}
