import QtQuick 2.15
import SortFilterProxyModel 0.2

import 'components/collectionList' as CollectionList
import 'components/gameList' as GameList
import 'components/gameDetails' as GameDetails
import 'components/settings' as Settings
import 'components/resources' as Resources
import 'components/themes' as Themes

FocusScope {
    id: root;

    property string currentView: 'collectionList';
    property string previousView: 'collectionList';
    property var currentViewCallbacks: [];

    property int currentCollectionIndex: 0;
    property var currentCollection;
    property int currentGameIndex: 0;
    property var currentGame;

    function addCurrentViewCallback(callback) {
        currentViewCallbacks.push(callback);
    }

    onCurrentViewChanged: {
        for (let i = 0; i < currentViewCallbacks.length; i++) {
            currentViewCallbacks[i](currentView);
        }
    }

    onCurrentCollectionIndexChanged: {
        currentCollectionIndex = Math.max(0, Math.min(currentCollectionIndex, allCollections.length - 1));

        currentCollection = allCollections[currentCollectionIndex];
        collectionList.updateIndex(currentCollectionIndex);

        currentGameIndex = 0;
        // todo this is not updating currentGame correctly since game index is not changing if it's already zero
        // todo implement sound logic here or in the keypresses?
        // todo change these on-changed to proper functions to be called, then you can call updateGameIndex() here to ensure the currentGame is updated
    }

    onCurrentGameIndexChanged: {
        currentGameIndex = Math.max(0, Math.min(currentGameIndex, currentCollection.games.count - 1));

        currentGame = getMappedGame(currentGameIndex);
        gameList.updateIndex(currentGameIndex);
        // todo implement sound logic here or in the keypresses?
    }


    // code to handle reading and writing api.memory
    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'collectionList';

        currentCollectionIndex = api.memory.get('currentCollectionIndex') ?? 0;
        currentGameIndex = api.memory.get('currentGameIndex') ?? 0;

        // this is done in here to prevent a quick flash of light mode
        theme.setDarkMode(settings.get('darkMode'));
        theme.setFontScale(settings.get('smallFont'));

        sounds.start();
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);

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
            return api.allGames.get(allLastPlayed.mapToSource(filterLastPlayed.mapToSource(index)));
        } else {
            return currentCollection.games.get(index);
        }
    }

    SortFilterProxyModel {
        id: allFavorites;

        sourceModel: api.allGames;
        filters: ValueFilter { roleName: 'favorite'; value: true; }
    }

    SortFilterProxyModel {
        id: allLastPlayed;

        sourceModel: api.allGames;
        filters: ValueFilter { roleName: 'lastPlayed'; value: ''; inverted: true; }
        sorters: RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder; }
    }

    SortFilterProxyModel {
        id: filterLastPlayed;

        sourceModel: allLastPlayed;
        filters: IndexFilter { maximumIndex: 24; }
    }


    // data components
    Settings.Handler { id: settings; }
    Themes.Handler { id: theme; }
    Resources.CollectionData { id: collectionData; }
    Resources.Sounds { id: sounds; }
    Resources.Music { id: music; }

    FontLoader {
        id: glyphs;

        property string favorite: '\ue805';
        property string unfavorite: '\ue802';
        property string settings: '\uf1de';
        property string enabled: '\ue800';
        property string disabled: '\uf096';
        property string play: '\ue801';

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
}
