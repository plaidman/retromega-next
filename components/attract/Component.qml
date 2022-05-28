import QtQuick 2.15
import QtMultimedia 5.9
import SortFilterProxyModel 0.2

Item {
    property bool showTitle: false;
    property var currentAttractGame;
    property bool isPlaying: false;

    anchors.fill: parent;

    function quietAttractCallback(enabled) {
        if (enabled) attractPlayer.volume = 0;
        else attractPlayer.volume = .7;
    }

    function onCancelPressed() {
        isPlaying = false;
        currentView = 'collectionList';
        sounds.back();
    }

    function onDetailsPressed() {
        //todo show/hide title
    }

    function onAcceptPressed() {
        attractPlayer.source = currentAttractGame.assets.video;
        currentAttractGame.launch();
        // todo do we need to pause video?
        // todo test to be sure it's starting the correct game, even if the video title is not right
    }

    function stopVideo() {
        if (attractPlayer.volume > 0) music.loud();
        isPlaying = false;
        attractPlayer.stop();
    }

    function startVideo() {
        if (attractPlayer.volume > 0) music.quiet();
        isPlaying = true;
        nextVideo();
    }

    function nextVideo() {
        // todo display a message if attractGames.count is zero
        const gameCount = attractGames.count;
        const randomIndex = Math.floor(Math.random() * gameCount);
        currentAttractGame = api.allGames.get(attractGames.mapToSource(randomIndex));

debug.text = currentAttractGame.assets.video;
        attractPlayer.source = currentAttractGame.assets.video;
        attractPlayer.play();
    }

    Keys.onUpPressed: { event.accepted = true; nextVideo(); }
    Keys.onDownPressed: { event.accepted = true; nextVideo(); }
    Keys.onLeftPressed: { event.accepted = true; nextVideo(); }
    Keys.onRightPressed: { event.accepted = true; nextVideo(); }

    Keys.onReleased: {
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            onCancelPressed();
        }
    }

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onDetailsPressed();
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            nextVideo();
        }
    }

    SortFilterProxyModel {
        id: attractGames;

        sourceModel: api.allGames;
        filters: [
            ExpressionFilter { expression: { assets.video !== ''; } }
        ]
    }

    Component.onCompleted: {
        addCurrentViewCallback(function (currentView) {
            // todo black screen if pegasus is started on attract mode, maybe set back to collection view
            if (currentView === 'attract') {
                startVideo();
            } else {
                stopVideo();
            }
        });

        quietAttractCallback(settings.get('quietVideo'));
        settings.addCallback('quietVideo', quietAttractCallback);
    }

    Connections {
        // todo resuming to foreground makes video loud
        target: Qt.application;
        function onStateChanged() {
            if (currentView !== 'attract') return;

            if (Qt.application.state === Qt.ApplicationActive) {
                startVideo();
            } else {
                stopVideo();
            }
        }
    }

    Video {
        id: attractPlayer;

        volume: 0.7;
        fillMode: VideoOutput.PreserveAspectFit;
        anchors.fill: parent;

        onStopped: {
            // only do this if the video stops BECAUSE it reached the end of the video
            if (isPlaying && status === MediaPlayer.EndOfMedia) {
                nextVideo();
            }
        }
    }
}
