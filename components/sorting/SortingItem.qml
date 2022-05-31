import QtQuick 2.15

Item {
    property string icon: {
        if (sortKey !== key) {
            if (defaultOrder === 'asc') return glyphs.ascend;
            return glyphs.descend;
        }

        if (sortDir === Qt.AscendingOrder) return glyphs.ascend;
        return glyphs.descend;
    }

    property double glyphOpacity: {
        if (sortKey !== key) return 0.3;
        return 1.0;
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            let muteSound = false;

            if (sortingListView.currentIndex !== index) {
                sortingListView.currentIndex = index;
                sounds.nav();
                muteSound = true;
            }

            onAcceptPressed(muteSound);
        }
    }

    Text {
        id: sortingIcon;

        text: icon;
        verticalAlignment: Text.AlignVCenter;
        color: sortingListView.currentIndex === index
            ? theme.current.focusTextColor
            : theme.current.blurTextColor;
        opacity: glyphOpacity;
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
