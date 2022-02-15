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

    function init() { bgMusicTimer.start(); }
    function shuffle() { bgPlaylist.shuffle(); }
    function play() { bgMusic.play(); }
    function stop() { bgMusic.stop(); }

    function toggle(enabled) {
        if (enabled) {
            shuffle();
            play();
        } else {
            stop();
        }
    }

    property bool isPlaying: {
        return bgMusic.playbackState === Audio.PlayingState;
    }

    Component.onCompleted: {
        settings.callbacks.bgMusic.push(toggle);
    }

    function blurFocus(newState) {
        if (settings.values.bgMusic === false) return;

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
            if (bgPlaylist.itemCount > 0 && settings.values.bgMusic) {
                bgPlaylist.shuffle();
                bgMusic.play();
            }
        }
    }
}
