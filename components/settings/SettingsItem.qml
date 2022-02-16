import QtQuick 2.15

Item {
    function itemTitle() {
        if (settings.get(modelData)) {
            return '+ ' + settings.title(modelData);
        } else {
            return '- ' + settings.title(modelData);
        }
    }

    Component.onCompleted: {
        settings.addCallback(modelData, function () {
            settingTitle.text = itemTitle();
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
        id: settingTitle;

        text: itemTitle();
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        color: settingsListView.currentIndex === index ? '#ffffff' : '#333333';
        height: parent.height;

        font {
            family: globalFonts.sans;
            pixelSize: parent.height * .43;
            letterSpacing: -0.3;
            bold: true;
        }

        anchors {
            left: parent.left;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
        }
    }
}
