import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: boxart;

    property bool showArt: true;
    property string artSource: {
        if (visible) return currentGame.assets.boxFront;
        else return '../../assets/images/clear.png';
    }

    function resizeImage(imgWid, imgHgt, parWid, parHgt) {
        const horizScale = parWid / imgWid;
        const vertScale = parHgt / imgHgt;
        const minScale = Math.min(horizScale, vertScale);

        boxartContainer.width = imgWid * minScale;
        boxartContainer.height = imgHgt * minScale;
    }

    Image {
        id: boxartShadow;

        source: '../../assets/images/cover-shadow.png';
        width: (371 / 200) * boxartImage.paintedWidth - 2;   // 371 is the total shadow image size
        height: (371 / 200) * boxartImage.paintedHeight - 2; // 200 is the black part of the image
        visible: false;
        anchors.centerIn: parent;
    }

    Item {
        id: boxartContainer;

        width: parent.width;
        height: parent.height;
        anchors.centerIn: parent;

        Image {
            id: boxartBuffer;

            fillMode: Image.PreserveAspectFit;
            asynchronous: false;
            anchors.centerIn: parent;
        }

        Image {
            id: boxartImage;

            fillMode: Image.PreserveAspectFit;
            source: artSource;
            asynchronous: true;
            anchors.fill: parent;
            cache: false;

            sourceSize {
                width: 640;
                height: 480;
            }

            onStatusChanged: {
                if (status === Image.Ready) {
                    boxartBuffer.source = source;
                    boxartBuffer.width = paintedWidth;
                    boxartBuffer.height = paintedHeight;

                    boxartShadow.visible = true;

                    resizeImage(paintedWidth, paintedHeight, boxart.width * .75, boxart.height * .75);
                }
            }
        }

        layer.enabled: true;
        layer.effect: OpacityMask {
            maskSource: Item {
                width: boxartImage.width;
                height: boxartImage.height;

                Rectangle {
                    width: boxartImage.width;
                    height: boxartImage.height;
                    radius: 6;
                }
            }
        }
    }
}
