import QtQuick 2.15

Item {
    function getGlyph() {
        if (settings.get(modelData)) {
            return glyphs.enabled;
        } else {
            return glyphs.disabled;
        }
    }

    Component.onCompleted: {
        settings.addCallback(modelData, function () {
            settingIcon.text = getGlyph();
        });
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if (settingsListView.currentIndex === index) {
                onAcceptPressed();
            } else {
                settingsListView.currentIndex = index;
                sounds.nav();
            }
        }
    }

    Text {
        id: settingIcon;

        text: getGlyph();
        verticalAlignment: Text.AlignVCenter;
        color: settingsListView.currentIndex === index
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
        id: settingTitle;

        text: settings.title(modelData);
        verticalAlignment: Text.AlignVCenter;
        color: settingsListView.currentIndex === index
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
            left: settingIcon.right;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
        }
    }
}
