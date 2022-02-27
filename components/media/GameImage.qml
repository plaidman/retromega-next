import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property bool failed: true;
    property string imageSource: '';
    property string videoSettingKey: '';

    visible: {
        if (failed) return false;
        if (currentCollection.games.count === 0) return false;
        if (imageSource.length === 0) return false;

        return true;
    }

    Image {
        id: boxartBuffer;

        // invisible because the dropshadow element essentially copies it
        visible: false;
        fillMode: Image.PreserveAspectFit;
        cache: false;
        width: parent.width * .75;
        height: parent.height * .75;
        anchors.centerIn: parent;
    }

    Image {
        id: boxartImage;

        // invisible because the buffer element is actually what is shown to prevent flickering
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

        // invisible because the dropshadow element essentially copies it
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

        // invisible because the dropshadow element essentially copies it
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
        anchors.fill: boxartRounded;
    }
}
