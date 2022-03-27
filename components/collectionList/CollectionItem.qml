import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            collectionListView.currentIndex = index;
            onAcceptPressed();
        }
    }

    // background stripe
    Image {
        source: '../../assets/images/stripe.png';
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignRight;

        anchors {
            fill: parent;
            rightMargin: 70;
        }
    }

    DropShadow {
        source: title;
        verticalOffset: 10;
        color: '#30000000';
        radius: 20;
        samples: 41;
        cached: true;
        anchors.fill: title;
    }

    Text {
        id: title;

        text: modelData.name;
        color: theme.current.titleColor;
        width: root.width * .46;
        wrapMode: Text.WordWrap;
        lineHeight: 0.8;

        font {
            pixelSize: root.height * .075;
            bold: true;
        }

        anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 30;
            verticalCenterOffset: -5;
        }
    }

    Text {
        text: modelData.games.count + ' games';
        color: theme.current.titleColor;
        opacity: 0.7;

        anchors {
            left: parent.left;
            leftMargin: 30;
            top: title.bottom;
            topMargin: root.height * .02;
        }

        font {
            pixelSize: root.height * .03;
            letterSpacing: -0.3;
            bold: true;
        }
    }

    Text {
        // todo .join(" • ") for year
        text: collectionData.getVendor(modelData.shortName);
        color: theme.current.titleColor;
        opacity: 0.7;

        font {
            capitalization: Font.AllUppercase;
            pixelSize: root.height * .025;
            letterSpacing: 1.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 30;
            bottom: title.top;
        }
    }

    Image {
        id: device;

        source: '../../assets/images/devices/' + collectionData.getImage(modelData.shortName) + '.png';
        width: root.width * .59;
        height: root.height * .78;
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignRight;
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
            NumberAnimation {
                properties: 'anchors.rightMargin';
                easing.type: Easing.InOutCubic;
                duration: 225;
            }
        }
    }
}
