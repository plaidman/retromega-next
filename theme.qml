import QtQuick 2.15
import SortFilterProxyModel 0.2

import 'components/collectionList' as CollectionList
import 'components/gameList' as GameList
import 'components/gameDetails' as GameDetails
import 'components/settings' as Settings
import 'components/resources' as Resources
import 'components/themes' as Themes
import 'components/sorting' as Sorting
import 'components/attract' as Attract

FocusScope {
    id: root;

    property string currentView: 'collectionList';
    property string previousView: 'collectionList';
    property var currentViewCallbacks: [];

    property int currentCollectionIndex: -1;
    property var currentCollection;
    property string currentShortName;
    property var currentGameList;
    property int currentGameIndex: -1;
    property var currentGame;

    property bool onlyFavorites: false;
    property bool onlyMultiplayer: false;
    property bool favoritesOnTop: false;
    property string sortKey: 'sortBy';
    property var sortDir: Qt.AscendingOrder;
    property string nameFilter: '';

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

    function updateSortedCollection() {
        if (currentShortName === 'favorites') {
            currentGameList = allFavorites;
        } else if (currentShortName === 'recents') {
            currentGameList = filterLastPlayed;
        } else {
            currentGameList = sortedCollection;
        }

        currentCollection = allCollections[currentCollectionIndex];
        updateGameIndex(0, true);
    }

    function updateCollectionIndex(newIndex, skipCollectionListUpdate = false) {
        const clampedIndex = clamp(0, newIndex, allCollections.length - 1);

        if (clampedIndex === currentCollectionIndex) return false;

        currentCollectionIndex = clampedIndex;
        currentShortName = allCollections[currentCollectionIndex].shortName;

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

        onlyFavorites = api.memory.get('onlyFavorites') ?? false;
        onlyMultiplayer = api.memory.get('onlyMultiplayer') ?? false;
        sortKey = api.memory.get('sortKey') ?? 'sortBy';
        sortDir = api.memory.get('sortDir') ?? Qt.AscendingOrder;
        nameFilter = api.memory.get('nameFilter') ?? '';

        favoritesOnTop = settings.get('favoritesOnTop');
        settings.addCallback('favoritesOnTop', function (enabled) {
            favoritesOnTop = enabled;
        });

        updateCollectionIndex(api.memory.get('currentCollectionIndex') ?? -1);
        updateSortedCollection();
        updateGameIndex(api.memory.get('currentGameIndex') ?? -1, true);

        // this is done in here to prevent a quick flash of default themes
        theme.setDarkMode(settings.get('darkMode'));
        theme.setButtonGuide(settings.get('buttonGuide'));
        theme.setFontScale(settings.get('smallFont'));

        if (settings.get('resetNameFilter')) {
            nameFilter = '';
        }

        sounds.start();
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);

        api.memory.set('onlyFavorites', onlyFavorites);
        api.memory.set('onlyMultiplayer', onlyMultiplayer);
        api.memory.set('sortKey', sortKey);
        api.memory.set('sortDir', sortDir);
        api.memory.set('nameFilter', nameFilter);

        settings.saveAll();
    }


    // code to handle collection modification
    property var allCollections: {
        const collections = api.collections.toVarArray();

		if (settings.get('showFavorites')) {
			collections.unshift({'name': 'Favorites', 'shortName': 'favorites', 'games': allFavorites});
        }
		
		if (settings.get('showRecents')) {
			collections.unshift({'name': 'Last Played', 'shortName': 'recents', 'games': filterLastPlayed});
        }
		
		if (settings.get('showAllGames')) {
			collections.unshift({'name': 'All Games', 'shortName': 'allgames', 'games': api.allGames});
		}
		
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
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; },
            ExpressionFilter { enabled: onlyMultiplayer; expression: { return players > 1; } },
            RegExpFilter { roleName: 'title'; pattern: nameFilter; caseSensitivity: Qt.CaseInsensitive; enabled: nameFilter !== ''; }
        ]
        sorters: RoleSorter { roleName: sortKey; sortOrder: sortDir }
    }

    SortFilterProxyModel {
        id: filterLastPlayed;

        sourceModel: api.allGames;
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites; },
            ExpressionFilter { enabled: onlyMultiplayer; expression: { return players > 1; } },
            RegExpFilter { roleName: 'title'; pattern: nameFilter; caseSensitivity: Qt.CaseInsensitive; enabled: nameFilter !== ''; },
            ExpressionFilter {
                expression: {
                    const lastPlayedTime = lastPlayed.getTime();
                    if (isNaN(lastPlayedTime)) return false;

                    const curTime = new Date().getTime();
                    const lastMonth = 1000 * 60 * 60 * 24 * 31; // ms in 31 days
                    return (curTime - lastPlayedTime < lastMonth)
                }
            }
        ]
        sorters: [
            RoleSorter { roleName: 'favorite'; sortOrder: Qt.DescendingOrder; enabled: favoritesOnTop; },
            RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder; }
        ]
    }

    SortFilterProxyModel {
        id: sortedCollection;

        sourceModel: currentCollection.games;
        sorters: [
            RoleSorter { roleName: 'favorite'; sortOrder: Qt.DescendingOrder; enabled: favoritesOnTop; },
            RoleSorter { roleName: sortKey; sortOrder: sortDir }
        ]
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites; },
            ExpressionFilter { enabled: onlyMultiplayer; expression: { return players > 1; } },
            RegExpFilter { roleName: 'title'; pattern: nameFilter; caseSensitivity: Qt.CaseInsensitive; enabled: nameFilter !== ''; }
        ]
    }


    // data components
    Settings.Handler { id: settings; }
    Themes.Handler { id: theme; }
    Resources.CollectionData { id: collectionData; }
    Resources.GameData { id: gameData; }
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
        property string fullStar: '\ue803';
        property string halfStar: '\uf123';
        property string emptyStar: '\ue804';
        property string search: '\ue806';
        property string cancel: '\ue807';

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
        id: sortingComponent;

        visible: currentView === 'sorting';
        focus: currentView === 'sorting';
    }

    Attract.Component {
        id: attractComponent;

        visible: currentView === 'attract';
        focus: currentView === 'attract';
    }

    /* Text { id: debug; x: 20; y: 20; width: 20; height: 20; text: 'debug'; color: 'magenta'; } */
    /* Rectangle { width: 640; height: 480; color: 'transparent'; border.color: 'magenta'; } */
    /* Rectangle { width: 1280; height: 720; color: 'transparent'; border.color: 'magenta'; } */
}
