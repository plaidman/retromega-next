import QtQuick 2.15

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
        currentCollection = api.collections.get(currentCollectionIndex);

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
