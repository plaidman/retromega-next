import QtQuick 2.15

import '../media' as Media

Item {
    property alias video: gameListVideo;
    property alias gamesListView: gamesListView;
    property double itemHeight: {
        return gamesListView.height * .12 * theme.fontScale;
    }

    property string imgSrc: {
        if (currentGame === null) return '';
        return currentGame.assets.boxFront;
    }

    Component.onCompleted: {
        gamesListView.currentIndex = currentGameIndex;
        gamesListView.positionViewAtIndex(currentGameIndex, ListView.Center);

        settings.addCallback('gameListVideo', function () {
            gameListVideo.switchVideo();
        });
    }

    Text {
        visible: currentGameList.count === 0;
        text: 'No Games';
        anchors.centerIn: parent;
        color: theme.current.blurTextColor;
        opacity: 0.5;

        font {
            family: globalFonts.sans;
            pixelSize: parent.height * .065;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    ListView {
        id: gamesListView;

        model: currentGameList;
        delegate: lvGameDelegate;
        width: (parent.width / 2) - 20; // 20 is left margin
        height: parent.height - 24;
        highlightMoveDuration: 0;
        preferredHighlightBegin: itemHeight - 12; // height of an item minus top margin
        preferredHighlightEnd: parent.height - (itemHeight + 12); // height of an item plus bottom margin
        highlightRangeMode: ListView.ApplyRange;

        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
        }

        highlight: Rectangle {
            color: collectionData.getColor(currentCollection.shortName);
            opacity: theme.current.bgOpacity;
            radius: 8;
            width: gamesListView.width;
        }

        onCurrentIndexChanged: {
            gameListVideo.switchVideo();
        }
    }

    Component {
        id: lvGameDelegate;

        GameItem {
            width: gamesListView.width;
            height: itemHeight;
        }
    }

    Media.GameImage {
        id: gameListBoxart;

        width: parent.width / 2;
        height: parent.height;
        x: parent.width / 2;
        imageSource: imgSrc;
    }

    Media.GameVideo {
        id: gameListVideo;

        width: parent.width / 2;
        height: parent.height;
        x: parent.width / 2;
        settingKey: 'gameListVideo';
        validView: 'gameList';

        onVideoToggled: {
            gameListBoxart.videoPlaying = videoPlaying;
        }
    }
}
