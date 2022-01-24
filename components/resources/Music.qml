import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property alias count: bgPlaylist.itemCount;

    function shuffle() { bgPlaylist.shuffle(); }
    function play() { bgMusic.play(); }
    function stop() { bgMusic.stop(); }

    Audio {
        id: bgMusic;

        volume: 0.3;

        playlist: Playlist {
            id: bgPlaylist;

            playbackMode: Playlist.Loop;

            // add music files into assets/music
            // uncomment PlaylistItem below and repeat for each music file
            // PlaylistItem { source: '../../assets/music/whatever.mp3'; }
        }
    }
}
