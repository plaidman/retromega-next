import QtQuick 2.15
import QtGraphicalEffects 1.12
import "qrc:/qmlutils" as PegasusUtils

import '../media' as Media

Item {
    property var blurSource;

    // solves some kerning issues with period and commas
    // todo test this on retroid
    property var descText: {
        return currentGame.description
            .replace(/\. {1,}/g, '.  ')
            .replace(/, {1,}/g, ',  ');
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

    Text {
        text: descText;
        wrapMode: Text.WordWrap;
        lineHeight: 1.2;
        color: theme.current.detailsColor;
        horizontalAlignment: Text.AlignJustify;

        anchors {
            fill: parent;
            margins: 50;
        }

        font {
            pixelSize: parent.height * .035 * theme.fontScale;
            letterSpacing: -0.35;
            bold: true;
        }
    }
}
