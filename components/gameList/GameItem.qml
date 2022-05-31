import QtQuick 2.15

Item {
    property bool showFavorite: {
        return favorite
            && currentCollection.shortName !== 'favorites'
            && onlyFavorites === false;
    }

    MouseArea {
        anchors.fill: parent;

        onClicked: {
            if (gamesListView.currentIndex === index) {
                onAcceptPressed();
            } else {
                const updated = updateGameIndex(index);
                if (updated) { sounds.nav(); }
            }
        }

        onPressAndHold: {
            if (gamesListView.currentIndex === index) {
                onDetailsPressed();
            } else {
                const updated = updateGameIndex(index);
                if (updated) { sounds.nav(); }
            }
        }
    }

    Text {
        id: gameTitle;

        text: title;
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        color: gamesListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            pixelSize: parent.height * .43;
            letterSpacing: -0.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 12;
            right: parent.right;
            rightMargin: showFavorite ? parent.height * .36 + 10 : 10;
        }
    }

    Text {
        visible: showFavorite;
        text: glyphs.favorite;
        verticalAlignment: Text.AlignVCenter;
        color: gamesListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .3;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 10;
        }
    }
}
