import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            collectionListView.currentIndex = index;

            currentGameIndex = 0;
            currentGame = currentCollection.games.get(0);

            currentView = 'gameList';
            sounds.forwardSound.play();
        }
    }

    // background stripe
    Image {
        source: '../../assets/images/menu-side.png';
        fillMode: Image.PreserveAspectFit;
        height: parent.height;

        anchors {
            top: parent.top;
            right: parent.right;
            rightMargin: 70;
        }
    }

    Text {
        id: title;

        text: name;
        color: '#ffffff';
        width: 300;
        wrapMode: Text.WordWrap;
        lineHeight: 0.8;

        font {
            pixelSize: 36;
            bold: true;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 30;
            verticalCenterOffset: -5;
        }
    }

    DropShadow {
        source: title;
        verticalOffset: 10;
        color: '#40000000';
        radius: 20;
        samples: 20;
        anchors.fill: title;
    }

    Text {
        text: games.count + ' games';
        color: '#ffffff';
        opacity: 0.7;

        anchors {
            left: parent.left;
            leftMargin: 30;
            top: title.bottom;
            topMargin: 10;
        }

        font {
            pixelSize: 14;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    Text {
        text: collectionCompany(shortName);
        color: '#ffffff';
        opacity: 0.7;

        font {
            capitalization: Font.AllUppercase;
            pixelSize: 12;
            letterSpacing: 1.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 30;
            bottom: title.top;
            bottomMargin: -1;
        }
    }

    Image {
        id: device;

        source: '../../assets/images/devices/' + shortName + '.png';
        asynchronous: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            verticalCenterOffset: 10;
            right: parent.right;
            rightMargin: 0;
        }

        states: [
            State {
                name: 'active';
                when: collectionListView.currentIndex === index;
                PropertyChanges { target: device; anchors.rightMargin: -60.0; }
            },

            State {
                name: 'inactiveRight';
                when: collectionListView.currentIndex < index;
                PropertyChanges { target: device; anchors.rightMargin: -160.0; }
            },

            State {
                name: 'inactiveLeft';
                when: collectionListView.currentIndex > index;
                PropertyChanges { target: device; anchors.rightMargin: 40.0; }
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: 'anchors.rightMargin'; easing.type: Easing.InOutCubic; duration: 225  }
        }
    }
}
