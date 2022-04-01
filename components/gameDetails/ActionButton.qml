import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property string glyph;

    Rectangle {
        id: button;

        color: collectionData.getColor(currentCollection.shortName);
        opacity: theme.current.bgOpacity;
        radius: parent.height * .05;
        width: parent.width;
        height: parent.height;
        visible: false;

        Text {
            text: glyph;
            color: theme.current.bgColor;

            font {
                family: glyphs.name;
                pixelSize: parent.height * .50;
            }

            anchors {
                verticalCenter: parent.verticalCenter;
                horizontalCenter: parent.horizontalCenter;
            }
        }
    }

    DropShadow {
        source: button;
        verticalOffset: 5;
        color: '#60000000';
        radius: 15;
        samples: 31;
        cached: true;
        anchors.fill: button;
    }
}
