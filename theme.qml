import QtQuick 2.15
import SortFilterProxyModel 0.2

import 'components/collectionList' as CollectionList
import 'components/gameList' as GameList
import 'components/settings' as Settings
import 'components/resources' as Resources
import 'components/themes' as Themes

FocusScope {
    id: root;

    property string currentView: 'collectionList';
    property string previousView: 'collectionList';
    property int currentCollectionIndex: 0;
    property var currentCollection;
    property int currentGameIndex: 0;
    property var currentGame;


    // code to handle reading and writing api.memory
    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'collectionList';

        currentCollectionIndex = api.memory.get('currentCollectionIndex') ?? 0;
        currentCollection = allCollections[currentCollectionIndex];

        currentGameIndex = api.memory.get('currentGameIndex') ?? 0;
        currentGame = getMappedGame(currentGameIndex);

        settings.set('bgMusic', api.memory.get('bgMusic') ?? true);
        settings.set('navSounds', api.memory.get('navSounds') ?? true);
        settings.set('darkMode', api.memory.get('darkMode') ?? false);
        settings.set('twelveHour', api.memory.get('twelveHour') ?? false);
        settings.set('smallFont', api.memory.get('smallFont') ?? false);
        settings.set('gameListVideo', api.memory.get('gameListVideo') ?? true);

        theme.setDarkMode(settings.get('darkMode'));
        theme.setFontScale(settings.get('smallFont'));
        sounds.start();
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);

        api.memory.set('bgMusic', settings.get('bgMusic'));
        api.memory.set('navSounds', settings.get('navSounds'));
        api.memory.set('darkMode', settings.get('darkMode'));
        api.memory.set('twelveHour', settings.get('twelveHour'));
        api.memory.set('smallFont', settings.get('smallFont'));
        api.memory.set('gameListVideo', settings.get('gameListVideo'));
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
        property string settings: '\uf1de';
        property string enabled: '\ue800';
        property string disabled: '\uf096';

        source: "assets/images/fontello.ttf";
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            music.blurFocus(Qt.application.state);
        }
    }


    // ui components
    CollectionList.Component {
        visible: currentView === 'collectionList';
        focus: currentView === 'collectionList';
    }

    GameList.Component {
        visible: currentView === 'gameList';
        focus: currentView === 'gameList';
    }

    Settings.Component {
        visible: currentView === 'settings';
        focus: currentView === 'settings';
    }
}
