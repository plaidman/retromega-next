import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    property var blurSource;
    property alias textInput: nameFilterTextInput;

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

    Rectangle {
        width: parent.width * .5;
        height: parent.height * .5;

        anchors {
            verticalCenter: parent.verticalCenter;
            horizontalCenter: parent.horizontalCenter;
        }

        TextInput {
            id: nameFilterTextInput;

            text: nameFilter;
            width: parent.width;
            height: parent.height;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
    }
}
