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

    property alias count: bgPlaylist.itemCount;

    function init() { bgMusicTimer.start(); }
    function shuffle() { bgPlaylist.shuffle(); }
    function play() { bgMusic.play(); }
    function pause() { bgMusic.pause(); }
    function stop() { bgMusic.stop(); }
    function isPlaying() { return bgMusic.playbackState === Audio.PlayingState; }

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
            if (music.count > 0 && bgMusicEnabled) {
                music.shuffle();
                music.play();
            }
        }
    }
}
