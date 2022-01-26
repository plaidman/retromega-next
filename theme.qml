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

        collections.unshift({"name": "Favorites", "shortName": "favorites", "games": allFavorites});
        collections.unshift({"name": "Last Played", "shortName": "recents", "games": filterLastPlayed});
        collections.unshift({"name": "All Games", "shortName": "allgames", "games": api.allGames});

        return collections;
    };

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
        currentGame = currentCollection.games.get(currentGameIndex);

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
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    SortFilterProxyModel {
        id: allLastPlayed;

        sourceModel: api.allGames;
        filters: ValueFilter { roleName: "lastPlayed"; value: ""; inverted: true; }
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder; }
    }

    SortFilterProxyModel {
        id: filterLastPlayed;

        sourceModel: allLastPlayed;
        filters: IndexFilter { maximumIndex: 25; }
    }

    /* SortFilterProxyModel { */
    /*     id: currentFavorites; */

    /*     sourceModel: currentCollection.games; */
    /*     filters: ValueFilter { roleName: "favorite"; value: true; } */
    /* } */

    /* SortFilterProxyModel { */
    /* id: searchGames */

    /*     sourceModel: currentCollection.games */
    /*     filters: [ */
    /*          RegExpFilter { roleName: "title"; pattern: searchValue; caseSensitivity: Qt.CaseInsensitive; enabled: searchValue != "" } */
    /*     ] */
    /*     // sorters: [ */
    /*     //     RoleSorter { roleName: sortByFilter[sortByIndex]; sortOrder: orderBy } */
    /*     // ] */
    /* } */

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

    Rectangle {
        // debug
        /* x: 200; */
        width: 640;
        height: 480;

        CollectionList.Component {
            visible: currentView === 'collectionList';
            focus: currentView === 'collectionList';
        }

        GameList.Component {
            visible: currentView === 'gameList';
            focus: currentView === 'gameList';
        }

        // debug
        Rectangle {
            x: 100;
            y: 100;
            width: debug.width + 10;
            height: debug.height + 10;

            color: 'black';
            border.color: 'white';

            Text {
                id: debug;

                text: 'debug';
                color: 'magenta';
                anchors.centerIn: parent;
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                }
            }
        }
    }
}
