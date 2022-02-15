import QtQuick 2.15
import QtMultimedia 5.9

Item {
    Playlist {
        id: bgPlaylist;

        playbackMode: Playlist.Loop;

        // add music files into assets/music
        // uncomment PlaylistItem below and repeat for each music file
        // PlaylistItem { source: '../../assets/music/whatever.mp3'; }
    }

    property bool isPlaying: {
        return bgMusic.playbackState === Audio.PlayingState;
    }

    Component.onCompleted: {
        settings.addCallback('bgMusic', function (enabled) {
            if (enabled) {
                bgPlaylist.shuffle();
                bgMusic.play();
            } else {
                bgMusic.stop();
            }
        });
    }

    function init() { bgMusicTimer.start(); }
    function blurFocus(newState) {
        if (settings.get('bgMusic') === false) return;

        if (newState === Qt.ApplicationActive) {
            if (!isPlaying) bgMusic.play();
        } else {
            if (isPlaying) bgMusic.pause();
        }
    }

    Audio {
        id: bgMusic;

        volume: 0.3;
        playlist: bgPlaylist;
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
