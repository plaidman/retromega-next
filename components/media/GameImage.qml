import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property bool failed: true;
    property bool videoPlaying: false;
    property string imageSource: '';

    visible: {
        if (failed) return false;
        if (videoPlaying) return false;
        if (currentCollection.games.count === 0) return false;
        if (imageSource.length === 0) return false;

        return true;
    }

    Image {
        id: boxartBuffer;

        // invisible - displayed by the dropshadow element
        visible: false;
        fillMode: Image.PreserveAspectFit;
        cache: false;
        width: parent.width * .75;
        height: parent.height * .75;
        anchors.centerIn: parent;
    }

    Image {
        id: boxartImage;

        // invisible - boxartBuffer is shown and updated to prevent flickering
        visible: false;
        fillMode: Image.PreserveAspectFit;
        source: imageSource;
        asynchronous: true;
        cache: false;
        width: parent.width * .75;
        height: parent.height * .75;
        anchors.centerIn: parent;

        onStatusChanged: {
            if (status == Image.Null) {
                failed = true;
            }

            if (status == Image.Error) {
                failed = true;
            }

            if (status === Image.Ready) {
                failed = false;
                boxartBuffer.source = source;
            }
        }
    }

    Item {
        id: boxartMask;

        // invisible - displayed by the dropshadow element
        visible: false;
        anchors.fill: boxartBuffer;

        Rectangle {
            color: 'white';
            radius: 10;
            anchors.centerIn: parent;
            width: boxartBuffer.paintedWidth;
            height: boxartBuffer.paintedHeight;
        }
    }

    OpacityMask {
        id: boxartRounded;

        // invisible - displayed by the dropshadow element
        visible: false;
        anchors.fill: boxartBuffer;
        source: boxartBuffer;
        maskSource: boxartMask;
    }

    DropShadow {
        source: boxartRounded;
        verticalOffset: 10;
        color: '#60000000';
        radius: 30;
        samples: 61;
        cached: true;
        anchors.fill: boxartRounded;
    }
}
