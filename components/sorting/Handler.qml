import QtQuick 2.15

Item {
    property alias model: model;

    ListModel {
        id: model;

        ListElement {
            key: 'nameFilter';
            type: 'nameFilter';
        }

        ListElement {
            key: 'sortBy';
            title: 'Title';
            type: 'sort';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'lastPlayed';
            title: 'Last Played';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'rating';
            title: 'Rating';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'release';
            title: 'Release Date';
            type: 'sort';
            defaultOrder: 'asc';
        }

        ListElement {
            key: 'favorite';
            title: 'Favorites';
            type: 'sort';
            defaultOrder: 'desc';
        }

        ListElement {
            key: 'onlyFavorites';
            title: 'Only Favorites';
            type: 'onlyFavorites';
        }

        ListElement {
            key: 'onlyMultiplayer';
            title: 'Only Multiplayer';
            type: 'onlyMultiplayer';
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
            nameFilter: () => { sortingComponent.showModal(); },
            sortBy: updateSort('sortBy', Qt.AscendingOrder),
            lastPlayed: updateSort('lastPlayed', Qt.DescendingOrder),
            rating: updateSort('rating', Qt.DescendingOrder),
            release: updateSort('release', Qt.AscendingOrder),
            favorite: updateSort('favorite', Qt.DescendingOrder),
            onlyFavorites: () => { onlyFavorites = !onlyFavorites; },
            onlyMultiplayer: () => { onlyMultiplayer = !onlyMultiplayer; },
        };

        callbacks[key]();
    }
}
