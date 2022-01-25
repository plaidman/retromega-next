import QtQuick 2.15

Item {
    height: 28;
    width: 28;

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/music.png';
        asynchronous: true;
        opacity: .5;
        anchors.fill: parent;
        visible: !bgMusicEnabled;
    }

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/mute.png';
        asynchronous: true;
        opacity: .5;
        anchors.fill: parent;
        visible: bgMusicEnabled;
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            toggleMusicEnabled();
        }
    }
}
