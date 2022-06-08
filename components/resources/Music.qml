import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property var videos: [];
    Playlist {
        id: bgPlaylist;

        playbackMode: Playlist.Loop;

        // add music files into assets/music
        // uncomment PlaylistItem below and repeat for each music file
        // PlaylistItem { source: '../../assets/music/whatever.mp3'; }
    }

    function volumeCheck() {
        if (settings.get('quietVideo') === true) {
            bgMusic.volume = 0.3;
            return;
        }

        for (let i = 0; i < videos.length; i++) {
            if (videos[i].playbackState === MediaPlayer.PlayingState) {
                bgMusic.volume = 0.05;
                return;
            }
        }

        bgMusic.volume = 0.3;
    }

    function registerVideo(video) {
        videos.push(video);
    }

    property bool isPlaying: {
        return bgMusic.playbackState === Audio.PlayingState;
    }

    Component.onCompleted: {
        bgMusicTimer.start();

        settings.addCallback('bgMusic', function (enabled) {
            if (enabled) {
                bgPlaylist.shuffle();
                bgMusic.play();
            } else {
                bgMusic.stop();
            }
        });
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (settings.get('bgMusic') === false) return;

            if (Qt.application.state === Qt.ApplicationActive) {
                if (!isPlaying) bgMusic.play();
            } else {
                if (isPlaying) bgMusic.pause();
            }
        }
    }

    Audio {
        id: bgMusic;

        volume: 0.3;
        playlist: bgPlaylist;

        Behavior on volume {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad; }
        }
    }

    Timer {
        id: bgMusicTimer;

        interval: 300;
        repeat: false;
        onTriggered: {
            if (bgPlaylist.itemCount > 0 && settings.get('bgMusic')) {
                bgPlaylist.shuffle();
                bgMusic.play();
            }
        }
    }
}
