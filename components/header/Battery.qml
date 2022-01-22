import QtQuick 2.15

Item {
    property bool lightText: true;

    width: 27;
    height: 14;

    // battery outline
    Image {
        source: lightText ? '../../assets/images/battery.png' : '../../assets/images/battery-dark.png';
        anchors.centerIn: parent;
    }

    // battery percentage fill
    Rectangle {
        color: lightText ? '#ffffff' : '#000000';
        radius: 2;
        width: Math.max(api.device.batteryPercent * 17.6, 2);
        height: 8;

        anchors {
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 3;
        }
    }
}
