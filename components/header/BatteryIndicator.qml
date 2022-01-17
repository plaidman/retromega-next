import QtQuick 2.15

Item {
    width: 27;
    height: 14;

    // battery outline
    Image {
        source: '../../assets/images/battery-dark.png';

        anchors {
            centerIn: parent;
        }
    }

    // battery percentage fill
    Rectangle {
        color: '#000000';
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
