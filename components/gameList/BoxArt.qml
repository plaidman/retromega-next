import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    function resizeImage(imgWid, imgHgt, parWid, parHgt) {
        const horizScale = parWid / imgWid;
        const vertScale = parHgt / imgHgt;
        const minScale = Math.min(horizScale, vertScale);

        debug.text = minScale;

        boxartImage.width = imgWid * minScale;
        boxartImage.height = imgHgt * minScale;
    }

    Image {
        id: boxartShadow;

        source: "../../assets/images/cover-shadow.png";
        width: (371 / 200) * boxartImage.paintedWidth - 2;   // 371 is the total shadow image size
        height: (371 / 200) * boxartImage.paintedHeight - 2; // 200 is the black part of the image
        visible: false;
        anchors.centerIn: parent;
    }

    /* Image { */
    /*     id: boxartBuffer; */

    /*     fillMode: Image.PreserveAspectFit; */
    /*     asynchronous: false; */
    /*     anchors.centerIn: parent; */
    /* } */

    Image {
        id: boxartImage;

        fillMode: Image.PreserveAspectFit;
        source: currentGame.assets.boxFront;
        asynchronous: true;
        width: 1;
        height: 1;
        anchors.centerIn: parent;

        /* sourceSize { */
        /*     width: 640; */
        /*     height: 480; */
        /* } */

        onStatusChanged: {
            if (status == Image.Ready) {
                /* boxartBuffer.source = source; */
                /* boxartBuffer.width = paintedWidth; */
                /* boxartBuffer.height = paintedHeight; */

                boxartShadow.visible = true;

                resizeImage(paintedWidth, paintedHeight, parent.width * .75, parent.height * .75);
            }
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: boxartImage.width
                height: boxartImage.height
                anchors.centerIn: boxartImage;

                Rectangle {
                    anchors.centerIn: parent
                    width: boxartImage.width
                    height: boxartImage.height
                    radius: 6
                }
            }
        }
    }
}











/* Item { */
/*     // When the box art is used across screens, */
/*     // context signals when the contents needs to be reset */
/*     // Basically avoids seeing previous artwork on an unrelated screen / state */
/*     property var context: "default" */

/*     // Asset to load */
/*     property var asset: string */

/*     // If first time the box art is loaded. In this case loads sync */
/*     property var initialLoad: true */

/*     // State */
/*     property var loadingError: false */
/*     property var loadingImage: true */

/*     // Convenience */
/*     property var emptyAsset: { */
/*         return (asset == "" || asset == null) */
/*     } */

/*     onContextChanged: { */
/*         // When context changes, remove the cached image underneath */
/*         game_box_art_previous.source = "" */

/*         // If image is in process of loading then hide the shadow so we don't just see a black square & shadow */
/*         if (game_box_art.status == Image.Loading) { */
/*             game_box_shadow.opacity = 0 */
/*         } */
/*     } */

/*     function update_image_size(width, height, container_size) { */
/*         var fill = (width > height) ? 0.75 : 0.65 */
/*         box_art.width  = size_image(width, height, container_size * fill).width */
/*         box_art.height = size_image(width, height, container_size * fill).height */
/*     } */

/*     function size_image(width, height, max_width) { */
/*         var imageHeight = (height / width) * max_width */
/*         return { height: imageHeight, width: max_width } */
/*     } */

/*     id: box_art */
/*     width: 1 */
/*     height: 1 */
/*     anchors.horizontalCenter: parent.horizontalCenter */
/*     anchors.verticalCenter: parent.verticalCenter */
/*     visible: (emptyAsset || loadingError || initialLoad == true) ? false : true */

/*     // Shadow. Using an image for better shadow visuals & performance. */
/*     Image { */
/*         id: game_box_shadow */

/*         source: "../assets/images/cover-shadow.png" */
/*         width: (371 / 200) * parent.width    // 371 is the total shadow image size */
/*         height: (371 / 200) * parent.height  // 200 is the black part of the image */
/*         fillMode: Image.PreserveAspectFill */
/*         anchors.horizontalCenter: parent.horizontalCenter */
/*         anchors.verticalCenter: parent.verticalCenter */
/*     } */

/*     // Image container with rounded corners */
/*     Item { */
/*         property bool rounded: true */
/*         id: box_art_container */
/*         anchors.horizontalCenter: parent.horizontalCenter */
/*         anchors.verticalCenter: parent.verticalCenter */
/*         width: parent.width */
/*         height: parent.height */

/*         // Cached image of the last box art that was shown. */
/*         // This is used to avoid the box art  flickering when scrolling and images are loading. */
/*         Image { */
/*             anchors.fill: parent */
/*             id: game_box_art_previous */
/*             smooth: true */
/*             fillMode: Image.PreserveAspectCrop */
/*             asynchronous: false */
/*         } */

/*         // Main image that's primarily seen. */
/*         Image { */
/*             anchors.fill: parent */
/*             id: game_box_art */
/*             smooth: true */
/*             property bool adapt: true */
/*             fillMode: Image.PreserveAspectCrop */
/*             source: asset */
/*             asynchronous: initialLoad ? false : true */
/*             sourceSize: { width: 320; height: 320 } */
/*             onStatusChanged: { */

/*                 if (status == Image.Null || status == Image.Error) { */
/*                     box_art.loadingError = true */
/*                 } */

/*                 if (status == Image.Loading) { */
/*                     loadingImage = true */
/*                     opacity = 0 */
/*                     if (game_box_art_previous.source == "") { */
/*                         game_box_shadow.opacity = 0 */
/*                     } */
/*                 } */

/*                 if (status == Image.Ready) { */
/*                     update_image_size(game_box_art.implicitWidth, game_box_art.implicitHeight, 320); */
/*                     game_box_art_previous.source = source */
/*                     game_box_shadow.opacity = 1.0 */
/*                     opacity = 1.0 */
/*                     box_art.loadingError = false */
/*                     box_art.initialLoad = false */
/*                     box_art.loadingImage = false */
/*                     box_art.forceSync = false */
/*                 } */
/*             } */
/*         } */

/*         layer.enabled: rounded */
/*         layer.effect: OpacityMask { */
/*             maskSource: Item { */
/*                 width: game_box_art.width */
/*                 height: game_box_art.height */
/*                 Rectangle { */
/*                     anchors.centerIn: parent */
/*                     width: game_box_art.adapt ? game_box_art.width : Math.min(game_box_art.width, game_box_art.height) */
/*                     height: game_box_art.adapt ? game_box_art.height : width */
/*                     radius: 6 */
/*                 } */
/*             } */
/*         } */
/*     } */
/* } */
