import QtQuick 2.15
import SortFilterProxyModel 0.2

import 'components/collectionList' as CollectionList
import 'components/gameList' as GameList
import 'components/gameDetails' as GameDetails
import 'components/settings' as Settings
import 'components/resources' as Resources
import 'components/themes' as Themes
import 'components/sorting' as Sorting

FocusScope {
    id: root;

    property string currentView: 'collectionList';
    property string previousView: 'collectionList';
    property var currentViewCallbacks: [];

    property int currentCollectionIndex: -1;
    property var currentCollection;
    property var currentGameList;
    property int currentGameIndex: -1;
    property var currentGame;

    property bool onlyFavorites: false;
    property string sortKey: 'sortBy';
    property var sortDir: Qt.AscendingOrder;

    function addCurrentViewCallback(callback) {
        currentViewCallbacks.push(callback);
    }

    onCurrentViewChanged: {
        for (let i = 0; i < currentViewCallbacks.length; i++) {
            currentViewCallbacks[i](currentView);
        }
    }

    function clamp(min, val, max) {
        return Math.max(0, Math.min(val, max));
    }

    function updateCollectionIndex(newIndex, skipCollectionListUpdate = false) {
        const clampedIndex = clamp(0, newIndex, allCollections.length - 1);

        if (clampedIndex === currentCollectionIndex) return false;

        currentCollectionIndex = clampedIndex;
        currentCollection = allCollections[currentCollectionIndex];

        if (currentCollection.shortName === 'favorites') {
            currentGameList = allFavorites;
        } else if (currentCollection.shortName === 'recents') {
            currentGameList = filterLastPlayed;
        } else {
            currentGameList = sortedCollection;
        }

        updateGameIndex(0, true);

        // this prevents a circular update loop if we're updating from dragging the collection list
        if (!skipCollectionListUpdate) {
            collectionList.updateIndex(currentCollectionIndex);
        }

        return true;
    }

    function updateGameIndex(newIndex, forceUpdate = false) {
        const clampedIndex = clamp(0, newIndex, currentGameList.count - 1);

        if (!forceUpdate && clampedIndex === currentGameIndex) return false;

        currentGameIndex = clampedIndex;
        currentGame = getMappedGame(currentGameIndex);
        gameList.updateIndex(currentGameIndex);

        return true;
    }


    // code to handle reading and writing api.memory
    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'collectionList';

        updateCollectionIndex(api.memory.get('currentCollectionIndex') ?? -1);
        updateGameIndex(api.memory.get('currentGameIndex') ?? -1);

        onlyFavorites = api.memory.get('onlyFavorites') ?? false;
        sortKey = api.memory.get('sortKey') ?? 'sortBy';
        sortDir = api.memory.get('sortDir') ?? Qt.AscendingOrder;

        // this is done in here to prevent a quick flash of light mode
        theme.setDarkMode(settings.get('darkMode'));
        theme.setFontScale(settings.get('smallFont'));

        sounds.start();
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);

        api.memory.set('onlyFavorites', onlyFavorites);
        api.memory.set('sortKey', sortKey);
        api.memory.set('sortDir', sortDir);

        settings.saveAll();
    }


    // code to handle collection modification
    property var allCollections: {
        const collections = api.collections.toVarArray();

        collections.unshift({'name': 'Favorites', 'shortName': 'favorites', 'games': allFavorites});
        collections.unshift({'name': 'Last Played', 'shortName': 'recents', 'games': filterLastPlayed});
        collections.unshift({'name': 'All Games', 'shortName': 'allgames', 'games': api.allGames});

        return collections;
    };

    function getMappedGame(index) {
        if (currentCollection.shortName === 'favorites') {
            return api.allGames.get(allFavorites.mapToSource(index));
        } else if (currentCollection.shortName === 'recents') {
            return api.allGames.get(filterLastPlayed.mapToSource(index));
        } else {
            return currentCollection.games.get(sortedCollection.mapToSource(index));
        }
    }

    SortFilterProxyModel {
        id: allFavorites;

        sourceModel: api.allGames;
        filters: ValueFilter { roleName: 'favorite'; value: true; }
        sorters: RoleSorter { roleName: sortKey; sortOrder: sortDir }
    }

    SortFilterProxyModel {
        id: filterLastPlayed;

        sourceModel: api.allGames;
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites },
            ValueFilter { roleName: 'lastPlayed'; value: ''; inverted: true; },
            IndexFilter { maximumIndex: 24; }
        ]
        sorters: RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder; }
    }

    SortFilterProxyModel {
        id: sortedCollection;

        sourceModel: currentCollection.games;
        sorters: RoleSorter { roleName: sortKey; sortOrder: sortDir }
        filters: ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites }
    }


    // data components
    Settings.Handler { id: settings; }
    Themes.Handler { id: theme; }
    Resources.CollectionData { id: collectionData; }
    Resources.Sounds { id: sounds; }
    Resources.Music { id: music; }
    Sorting.Handler { id: sorting; }

    FontLoader {
        id: glyphs;

        property string favorite: '\ue805';
        property string unfavorite: '\ue802';
        property string settings: '\uf1de';
        property string enabled: '\ue800';
        property string disabled: '\uf096';
        property string play: '\ue801';
        property string ascend: '\uf160';
        property string descend: '\uf161';

        source: "assets/images/fontello.ttf";
    }


    // ui components
    CollectionList.Component {
        id: collectionList;

        visible: currentView === 'collectionList';
        focus: currentView === 'collectionList';
    }

    GameList.Component {
        id: gameList;

        visible: currentView === 'gameList';
        focus: currentView === 'gameList';
    }

    GameDetails.Component {
        visible: currentView === 'gameDetails';
        focus: currentView === 'gameDetails';
    }

    Settings.Component {
        visible: currentView === 'settings';
        focus: currentView === 'settings';
    }

    Sorting.Component {
        visible: currentView === 'sorting';
        focus: currentView === 'sorting';
    }
}
