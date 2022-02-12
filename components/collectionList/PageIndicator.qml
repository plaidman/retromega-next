import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: pageIndicator;

    property int currentIndex: 0;
    property int pageCount: 1;
    property double itemSpacing: {
        return Math.min(
            pageIndicator.width * .028 - pageIndicator.height,
            pageIndicator.width / pageCount - pageIndicator.height,
        );
    }

    Row {
        spacing: itemSpacing;
        anchors.horizontalCenter: parent.horizontalCenter;

        Repeater {
            model: pageCount;

            Rectangle {
                width: pageIndicator.height;
                height: pageIndicator.height;
                radius: pageIndicator.height / 2;

                color: currentIndex === index ? 'white' : '#20ffffff';
            }
        }
    }
}
