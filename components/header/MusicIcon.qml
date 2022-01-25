import QtQuick 2.15

Item {
    property string theme: 'light';

    height: 20;
    width: 20;

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/' + theme + '/music.png';
        asynchronous: true;
        opacity: .5;
        anchors.fill: parent;
        visible: !bgMusicEnabled;
    }

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/' + theme + '/mute.png';
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
