import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property double pixelSize;

    width: moreButton.width;
    height: moreButton.height;

    Rectangle {
        id: moreButton;

        color: theme.current.bgColor;
        visible: false;
        radius: 4;
        width: moreText.width * 1.3;
        height: moreText.height * 1.3;

        Text {
            id: moreText;

            text: 'MORE';
            color: collectionData.getColor(currentShortName);
            opacity: theme.current.bgOpacity;

            font {
                pixelSize: pixelSize;
                letterSpacing: -0.1;
                bold: true;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                horizontalCenter: parent.horizontalCenter;
            }
        }
    }

    DropShadow {
        radius: 15;
        samples: 31;
        color: theme.current.bgColor;
        source: moreButton;
        cached: true;
        spread: 0.25;
        anchors.fill: moreButton;
    }
}
