import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property alias bgMusic: bgMusic;
    property alias bgPlaylist: bgPlaylist;

    Audio {
        id: bgMusic
        playlist: Playlist {
            id: bgPlaylist
            playbackMode: "Loop"
            // add music files into assets/music
            // uncomment PlaylistItem below and repeat for each music file
            // PlaylistItem { source: "../../assets/music/whatever.mp3"; }
        }
        volume: 0.7
    }
}
