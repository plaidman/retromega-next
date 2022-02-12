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
        source: '../../assets/images/' + theme + '/favorite.svg';
        sourceSize: Qt.size( parent.height * .28, parent.height * .28 );
        fillMode: Image.PreserveAspectFit;
        visible: showFavorite;
        asynchronous: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 10;
        }

        Image {
            source: parent.source;
            width: 0
            height: 0
        }
    }
}
