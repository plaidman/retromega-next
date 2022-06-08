import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property var blurSource;

    function resetFlickable() {
        flickable.contentY = -flickable.topMargin;
    }

    function scrollUp() {
        flickable.contentY = Math.max(
            -flickable.topMargin,
            flickable.contentY - fullDesc.font.pixelSize,
        );
    }

    function scrollDown() {
        flickable.contentY = Math.min(
            flickable.contentY + fullDesc.font.pixelSize,
            flickable.contentHeight - root.height + flickable.bottomMargin,
        );
    }

    // solves some kerning issues with period and commas
    property var descText: {
        if (currentGame === null) return '';

        return currentGame.description
            .replace(/\. {1,}/g, '.  ')
            .replace(/, {1,}/g, ',  ');
    }

    property var fullDescText: {
        return descText + "\n\n" + filenames;
    }

    property var filenames: {
        if (currentGame.files.count === 1) {
            return 'file: ' + currentGame.files.get(0).path;
        }

        const files = [];
        for (let i = 0; i < currentGame.files.count; i++) {
            files.push(currentGame.files.get(i).path);
        }


        return "files:\n  - " + files.join("\n  - ");
    }

    // background to lighten or darken the blur effect, since it's translucent
    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    FastBlur {
        width: root.width;
        height: root.height;
        radius: 80;
        opacity: .4;
        source: blurSource;
        cached: true;
    }

    Flickable {
        id: flickable;

        contentWidth: fullDesc.width;
        contentHeight: fullDesc.height;
        flickableDirection: Flickable.VerticalFlick;
        anchors.fill: parent;
        clip: true;
        bottomMargin: 40;
        leftMargin: 40;
        rightMargin: 40;
        topMargin: 40;

        Behavior on contentY {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 150; }
        }

        Text {
            id: fullDesc;

            width: root.width - flickable.leftMargin - flickable.rightMargin;
            text: fullDescText;
            wrapMode: Text.WordWrap;
            lineHeight: 1.2;
            color: theme.current.detailsColor;
            horizontalAlignment: Text.AlignJustify;

            font {
                pixelSize: root.height * .045 * theme.fontScale;
                letterSpacing: -0.35;
                bold: true;
            }
        }
    }

    MouseArea {
        anchors.fill: parent;

        onClicked: {
            detailsButtonClicked('less');
        }
    }
}
