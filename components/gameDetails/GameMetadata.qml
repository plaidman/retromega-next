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

    property var metadataSpacing: {
        if (title.lineCount > 1 && metadataText.length > 3) return 3;
        return 8;
    }

    property var metadataText: {
        const texts = [
            gameData.releaseDateText,
            gameData.genreText,
            gameData.developedByText,
            gameData.playersText,
            gameData.lastPlayedText
        ];
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
