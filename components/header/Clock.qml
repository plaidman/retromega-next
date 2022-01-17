import QtQuick 2.15

Item {
    width: clock.width;
    height: clock.height;

    property bool twelveHour: false;
    property string timeFormat: {
        return twelveHour ? 'h:mm ap' : 'hh:mm';
    };

    Timer {
        id: clockTimer;

        interval: 30000;
        repeat: true;
        triggeredOnStart: true;

        onTriggered: {
            clock.text = Qt.formatTime(new Date(), timeFormat);
        }
    }

    // time
    Text {
        id: clock;

        text: '00:00';
        color: '#60000000';

        font {
            pixelSize: 18;
            letterSpacing: -0.3;
            bold: true;
        }

        Component.onCompleted: {
            twelveHour = api.memory.get('twelveHour') ?? false;
            clockTimer.start();
        }

        MouseArea {
            anchors {
                fill: parent;
            }

            onClicked: {
                twelveHour = !twelveHour;
                api.memory.set('twelveHour', twelveHour);
                clockTimer.restart();
            }
        }
    }
}
