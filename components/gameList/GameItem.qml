import QtQuick 2.15

Item {
    property string theme: {
        return gamesListView.currentIndex === index ? 'light' : 'dark';
    }
    property bool showFavorite: {
        return favorite && currentCollection.shortName !== 'favorites';
    }

    ListView.onRemove: {
        currentGameIndex = gamesListView.currentIndex;
        currentGame = getMappedGame(gamesListView.currentIndex);
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if (gamesListView.currentIndex === index) {
                onAcceptPressed();
            } else {
                gamesListView.currentIndex = index;
                currentGameIndex = index;
                currentGame = getMappedGame(index);
                sounds.nav();
            }
        }
    }

    Text {
        id: gameTitle;

        text: title;
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        color: gamesListView.currentIndex === index ? '#ffffff' : '#333333';
        height: parent.height;

        font {
            family: globalFonts.sans;
            pixelSize: 18;
            letterSpacing: -0.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 12;
            right: parent.right;
            rightMargin: showFavorite ? 24 : 12;
        }
    }

    Image {
        width: 12;
        visible: showFavorite;
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/' + theme + '/favorite.svg';
        asynchronous: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 10;
        }
    }
}
