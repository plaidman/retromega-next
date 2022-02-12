import QtQuick 2.15

Item {
    property string theme: 'light';

    height: parent.height * .44;
    width: parent.height * .44;

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/' + theme + '/mute.svg';
        sourceSize: Qt.size( parent.height, parent.height );
        asynchronous: true;
        opacity: .5;
        anchors.fill: parent;
        visible: !bgMusicEnabled;

        Image {
            source: parent.source;
            width: 0
            height: 0
        }
    }

    Image {
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/' + theme + '/music.svg';
        sourceSize: Qt.size( parent.height, parent.height );
        asynchronous: true;
        opacity: .5;
        anchors.fill: parent;
        visible: bgMusicEnabled;

        Image {
            source: parent.source;
            width: 0
            height: 0
        }
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            toggleMusicEnabled();
        }
    }
}
