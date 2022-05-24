import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property double pixelSize;

    property double actionButtonHeight: {
        return Math.min(
            actionButtons.height * .85,
            root.height * 0.1,
        );
    }

    property string genreText: {
        if (currentGame === null) return '';

        if (currentGame.genreList.length === 0) { return null; }

        const genre = currentGame.genreList[0] ?? '';
        const split = genre.split(',');

        if (split[0].length === 0) { return null; }

        return split[0];
    }

    property string lastPlayedText: {
        if (currentGame === null) return '';

        const lastPlayed = currentGame.lastPlayed.getTime();
        if (isNaN(lastPlayed)) return '';

        const now = new Date().getTime();

        let time = Math.floor((now - lastPlayed) / 1000);
        if (time < 60) {
            return 'Played ' + time + ' seconds ago';
        }

        time = Math.floor(time / 60);
        if (time < 60) {
            return 'Played ' + time + ' minutes ago';
        }

        time = Math.floor(time / 60);
        if (time < 24) {
            return 'Played ' + time + ' hours ago';
        }

        time = Math.floor(time / 24);
        return 'Played ' + time + ' days ago';
    }

    property string releaseDateText: {
        if (currentGame === null) return '';
        if (!currentGame.releaseYear) return '';
        return 'Released ' + currentGame.releaseYear;
    }

    property string playersText: {
        if (currentGame === null) return '';
        if (currentGame.players === 1) return '1 player';
        return currentGame.players + ' players';
    }

    property string developedByText: {
        if (currentGame === null) return '';

        if (currentGame.developer) {
            return 'Dev\'d by ' + currentGame.developer;
        }

        if (currentGame.publisher) {
            return 'Pub\'d by ' + currentGame.publisher;
        }

        return '';
    }

    property var metadataSpacing: {
        if (title.lineCount > 1 && metadataText.length > 3) return 3;
        return 8;
    }

    property var metadataText: {
        const texts = [releaseDateText, genreText, developedByText, playersText, lastPlayedText];
        return texts.filter(v => { return v !== null })
            .filter(v => { return v !== '' });
    }

    property string favoriteGlyph: {
        if (currentGame === null) return '';
        if (currentGame.favorite) return glyphs.favorite;
        return glyphs.unfavorite;
    }

    property string titleText: {
        if (currentGame === null) return '';
        return currentGame.title;
    }

    Text {
        id: title;

        width: parent.width;
        wrapMode: Text.WordWrap;
        maximumLineCount: 2;
        text: titleText;
        color: theme.current.detailsColor;
        elide: Text.ElideRight;

        font {
            pixelSize: pixelSize;
            letterSpacing: -0.35;
            bold: true;
        }

        anchors {
            left: parent.left;
            top: parent.top;
        }
    }

    Column {
        id: metadata;

        spacing: metadataSpacing;
        width: parent.width;

        anchors {
            top: title.bottom;
            topMargin: 8;
        }

        Repeater {
            model: metadataText;

            Text {
                text: modelData;
                color: theme.current.detailsColor;
                opacity: 0.5;
                width: parent.width;
                elide: Text.ElideRight
                maximumLineCount: 1;

                font {
                    pixelSize: pixelSize * .75;
                    letterSpacing: -0.35;
                    bold: true;
                }
            }
        }
    }

    Row {
        id: actionButtons;

        spacing: parent.width * .075;
        width: parent.width;

        anchors {
            top: metadata.bottom;
            topMargin: pixelSize;
            bottom: parent.bottom;
        }

        ActionButton {
            id: playButton;

            glyph: glyphs.play;
            width: parent.width / 2;
            height: actionButtonHeight;
            anchors.verticalCenter: parent.verticalCenter;

            MouseArea {
                anchors.fill: parent;

                onClicked: {
                    detailsButtonClicked('play');
                }
            }
        }

        ActionButton {
            id: favoriteButton;

            glyph: favoriteGlyph;
            width: parent.width / 2;
            height: actionButtonHeight;
            anchors.verticalCenter: parent.verticalCenter;

            MouseArea {
                anchors.fill: parent;

                onClicked: {
                    detailsButtonClicked('favorite');
                }
            }
        }
    }
}
