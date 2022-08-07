import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property string glyph;

    Rectangle {
        id: button;

        color: collectionData.getColor(currentShortName);
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
        anchors.fill: button;
        color: '#50000000';
        verticalOffset: 5;
        radius: 20;
        samples: 41;
        cached: true;
    }
}
