import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: boxart;

    property bool failed: true;
    visible: {
        currentCollection.games.count > 0 && !failed && currentGame.assets.boxFront.length > 0;
    }

    // must manually calculate width and height for the rounded corners
    // the shader doesn't work with paintedWidth and paintedHeight
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
            source: currentGame.assets.boxFront;
            asynchronous: true;
            anchors.fill: parent;
            cache: false;

            sourceSize {
                width: 640;
                height: 480;
            }

            onStatusChanged: {
                if (status == Image.Null) {
                    failed = true;
                    debug.text = 'null';
                }

                if (status == Image.Error) {
                    failed = true;
                    debug.text = 'error';
                }

                if (status === Image.Ready) {
                    failed = false;
                    debug.text = currentGame.assets.boxFront;
                    boxartBuffer.source = source;
                    boxartBuffer.width = paintedWidth;
                    boxartBuffer.height = paintedHeight;

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
