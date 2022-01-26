import QtQuick 2.15
import SortFilterProxyModel 0.2

import 'components/collectionList' as CollectionList
import 'components/gameList' as GameList
import 'components/resources' as Resources

FocusScope {
    property string currentView: 'collectionList';
    property var bgMusicEnabled: true;
    property int currentCollectionIndex: 0;
    property var currentCollection;
    property int currentGameIndex: 0;
    property var currentGame;

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

    Timer {
        id: bgMusicTimer;

        interval: 300;
        repeat: false;
        onTriggered: {
            if (music.count > 0 && bgMusicEnabled) {
                music.shuffle();
                music.play();
            }
        }
    }

    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'collectionList';

        currentCollectionIndex = api.memory.get('currentCollectionIndex') ?? 0;
        currentCollection = allCollections[currentCollectionIndex];

        currentGameIndex = api.memory.get('currentGameIndex') ?? 0;
        currentGame = getMappedGame(currentGameIndex);

        sounds.start();

        bgMusicEnabled = api.memory.get('bgMusicEnabled') ?? true;
        bgMusicTimer.start();
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);
        api.memory.set('bgMusicEnabled', bgMusicEnabled);
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

    Resources.CollectionData { id: collectionData; }
    function collectionColor(shortName) {
        return collectionData.colors[shortName] ?? collectionData.colors['default'];
    }
    function collectionCompany(shortName) {
        return collectionData.companies[shortName] ?? '';
    }

    Resources.Sounds { id: sounds; }

    Resources.Music { id: music; }
    function toggleMusicEnabled() {
        bgMusicEnabled = !bgMusicEnabled;

        if (bgMusicEnabled) {
            music.shuffle();
            music.play();
        } else {
            music.stop();
        }
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (!bgMusicEnabled) return;

            if (Qt.application.state === Qt.ApplicationActive) {
                if (!music.isPlaying()) music.play();
            } else {
                if (music.isPlaying()) music.pause();
            }
        }
    }

    CollectionList.Component {
        visible: currentView === 'collectionList';
        focus: currentView === 'collectionList';
    }

    GameList.Component {
        visible: currentView === 'gameList';
        focus: currentView === 'gameList';
    }
}
