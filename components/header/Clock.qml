import QtQuick 2.15

Item {
    property string theme: 'light';
    property string themeColor: {
        return theme === 'light' ? '#80ffffff' : '#80000000';
    }

    function updateTime() {
        let format = 'hh:mm';

        if (settings.values.twelveHour) {
            format = 'h:mm ap';
        }

        clock.text = Qt.formatTime(new Date(), format);
    }

    width: clock.width;

    Component.onCompleted: {
        clockTimer.start();
    }

    Timer {
        id: clockTimer;

        interval: 30000;
        repeat: true;
        triggeredOnStart: true;

        onTriggered: {
            updateTime();
        }
    }

    Text {
        id: clock;

        text: '00:00';
        color: themeColor;

        anchors.verticalCenter: parent.verticalCenter;

        font {
            pixelSize: parent.height * .33;
            letterSpacing: -0.3;
            bold: true;
        }

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                settings.toggle('twelveHour');
                clockTimer.restart();
            }
        }
    }
}
