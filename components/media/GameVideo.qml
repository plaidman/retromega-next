import QtQuick 2.15
import QtMultimedia 5.9
import QtGraphicalEffects 1.12

Item {
    property string settingKey: '';
    property string validView: '';
    signal videoToggled(bool videoPlaying);

    function switchVideo() {
        videoPlayer.stop();
        videoPlayer.source = '';

        music.loud();

        videoPlayerTimer.restart();
        videoToggled(false);
    }

    function videoOff() {
        switchVideo();
        videoPlayerTimer.stop();
    }

    Component.onCompleted: {
        addCurrentViewCallback(function (currentView) {
            if (currentView === validView) {
                switchVideo();
            } else {
                videoOff();
            }
        });
    }

    Connections {
        target: Qt.application;
        function onStateChanged() {
            if (videoPlayer.source === '') return;

            if (Qt.application.state === Qt.ApplicationActive) {
                switchVideo();
            } else {
                videoOff();
            }
        }
    }

    Timer {
        id: videoPlayerTimer;

        interval: 2000;
        repeat: false;
        onTriggered: {
            if (currentGame.assets.video === '') return;
            if (settings.get(settingKey) === false) return;
            if (currentView !== validView) return;

            videoToggled(true);

            music.quiet();

            videoPlayer.source = currentGame.assets.video;
            videoPlayer.play();
        }
    }

    Video {
        id: videoPlayer;

        visible: false;
        source: currentGame.assets.video;
        autoPlay: false;
        loops: MediaPlayer.Infinite;
        width: parent.width * .75;
        height: parent.height * .75;
        anchors.centerIn: parent;
        fillMode: VideoOutput.PreserveAspectFit;
    }

    DropShadow {
        source: videoPlayer;
        verticalOffset: 10;
        color: '#60000000';
        radius: 30;
        samples: 61;
        cached: true;
        anchors.fill: videoPlayer;
    }
}
