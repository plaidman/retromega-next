import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../media' as Media

Item {
    property alias video: gameDetailsVideo;

    // get rid of newlines for the short description
    // also some weird kerning on periods and commas for some reason
    property var introDescText: {
        if (currentGame === null) return '';

        return currentGame.description
            .replace(/\n/g, ' ')
            .replace(/ {2,}/g, ' ')
            .replace(/\. {1,}/g, '.  ')
            .replace(/, {1,}/g, ',  ');
    }

    property var hasMoreButton: {
        if (currentGame === null) return false;
        if (currentGame.description) return true;
        return false;
    }

    property string imgSrc: {
        if (currentGame === null) return '';
        return currentGame.assets.screenshot;
    }

    Component.onCompleted: {
        gameDetailsVideo.switchVideo();
        settings.addCallback('gameDetailsVideo', function () {
            gameDetailsVideo.switchVideo();
        });
    }

    GameMetadata {
        width: parent.width / 2 - 50;
        pixelSize: parent.height * .055;

        anchors {
            top: parent.top;
            topMargin: 25;
            bottom: detailsDivider.top;
            bottomMargin: parent.height * .035;
            left: parent.left;
            leftMargin: 25;
        }
    }

    Media.GameImage {
        id: gameDetailsScreenshot;

        width: parent.width / 2;
        height: parent.height * .675;
        x: parent.width / 2;
        imageSource: imgSrc;
    }

    Media.GameVideo {
        id: gameDetailsVideo;

        width: parent.width / 2;
        height: parent.height * .675;
        x: parent.width / 2;
        settingKey: 'gameDetailsVideo';
        validView: 'gameDetails';

        onVideoToggled: {
            gameDetailsScreenshot.videoPlaying = videoPlaying;
        }
    }

    Text {
        text: gameData.ratingText;
        color: theme.current.detailsColor;
        opacity: 0.5;
        width: parent.width / 2;
        height: parent.height * .65;
        x: parent.width / 2;
        verticalAlignment: Text.AlignBottom;
        horizontalAlignment: Text.AlignHCenter;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .04;
        }
    }

    Rectangle {
        id: detailsDivider;

        height: 1;
        color: theme.current.dividerColor;

        anchors {
            top: gameDetailsScreenshot.bottom;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

    Text {
        id: introDesc;

        text: introDescText;
        wrapMode: Text.WordWrap;
        horizontalAlignment: Text.AlignJustify;
        verticalAlignment: Text.AlignVCenter;
        color: theme.current.detailsColor;
        lineHeight: 1.3;
        elide: Text.ElideRight;

        font {
            pixelSize: parent.height * .04 * theme.fontScale;
            letterSpacing: -0.1;
            bold: true;
        }

        anchors {
            top: detailsDivider.bottom;
            topMargin: 10;
            bottom: parent.bottom;
            bottomMargin: 10;
            left: parent.left;
            leftMargin: 30;
            right: parent.right;
            rightMargin: 30;
        }

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                detailsButtonClicked('more');
            }
        }
    }

    MoreButton {
        pixelSize: parent.height * .04 * theme.fontScale;
        visible: hasMoreButton;

        anchors {
            right: parent.right;
            rightMargin: 30;
            bottom: introDesc.bottom;
            bottomMargin: parent.height * .01;
        }
    }
}
