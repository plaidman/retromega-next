import QtQuick 2.15

Item {
    property bool value;

    property string icon: {
        if (value) return glyphs.enabled;
        return glyphs.disabled;
    }

    Text {
        id: sortingIcon;

        text: icon;
        verticalAlignment: Text.AlignVCenter;
        color: sortingListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            family: glyphs.name;
            pixelSize: parent.height * .43;
        }

        anchors {
            left: parent.left;
            leftMargin: 20;
        }
    }

    Text {
        id: sortingTitle;

        text: title;
        verticalAlignment: Text.AlignVCenter;
        color: sortingListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        height: parent.height;

        font {
            family: globalFonts.sans;
            pixelSize: parent.height * .43;
            letterSpacing: -0.3;
            bold: true;
        }

        anchors {
            left: sortingIcon.right;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
        }
    }
}
