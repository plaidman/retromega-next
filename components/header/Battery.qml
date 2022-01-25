import QtQuick 2.15

Item {
    property string theme: 'light';
    property string themeColor: {
        return theme === 'light' ? '#ffffff' : '#000000';
    }

    width: 27;
    height: 14;

    // battery outline
    Image {
        source: '../../assets/images/' + theme + '/battery.png';
        anchors.centerIn: parent;
    }

    // battery percentage fill
    Rectangle {
        color: themeColor;
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
