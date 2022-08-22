import QtQuick 2.15
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2

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
        text: filteredGamesCollection.count + ' games';
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

    SortFilterProxyModel {
        id: filteredGamesCollection;

        sourceModel: allCollections[collectionListView.currentIndex].games;
        filters: [
            ValueFilter { roleName: 'favorite'; value: true; enabled: onlyFavorites; },
            ExpressionFilter { enabled: onlyMultiplayer; expression: { return players > 1; } },
            RegExpFilter { roleName: 'title'; pattern: nameFilter; caseSensitivity: Qt.CaseInsensitive; enabled: nameFilter !== ''; }
        ]
    }

    Text {
        text: collectionData.getVendorYear(modelData.shortName);
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
        width: root.width * .50;
        height: root.height * .65;
        fillMode: Image.PreserveAspectFit;
        horizontalAlignment: Image.AlignHCenter;
        asynchronous: true;
        smooth: true;
        visible: true;

        anchors {
            verticalCenter: parent.verticalCenter;
            verticalCenterOffset: 10;
            right: parent.right;
            rightMargin: root.width * .02;
        }
    }

    // DropShadow {
    //     source: device;
    //     verticalOffset: 10;
    //     color: '#30000000';
    //     radius: 20;
    //     samples: 41;
    //     cached: true;
    //     anchors.fill: device;
    // }
}
