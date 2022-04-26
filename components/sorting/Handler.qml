import QtQuick 2.15

Item {
    property alias model: model;
    ListModel {
        id: model;

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

    function updateSort(key, defaultSort) {
        return () => {
            if (sortKey !== key) {
                sortKey = key;
                sortDir = defaultSort;
                return;
            }

            if (sortDir === Qt.AscendingOrder) {
                sortDir = Qt.DescendingOrder;
                return;
            }

            sortDir = Qt.AscendingOrder;
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
        updateGameIndex(currentGameIndex, true);
    }
}
