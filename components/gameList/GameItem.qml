import QtQuick 2.15

Item {
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if (gamesListView.currentIndex === index) {
                onAcceptPressed();
            } else {
                gamesListView.currentIndex = index;
                currentGameIndex = index;
                currentGame = currentCollection.games.get(index);
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
            rightMargin: favorite ? 24 : 12;
        }
    }

    Image {
        width: 12;
        visible: favorite;
        fillMode: Image.PreserveAspectFit;
        source: '../../assets/images/favorite.svg';
        asynchronous: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 10;
        }
    }
}
