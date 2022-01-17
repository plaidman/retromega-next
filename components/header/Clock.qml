import QtQuick 2.15

Item {
    width: clock.width;
    height: clock.height;

    Timer {
        id: clockTimer;

        interval: 30000;
        repeat: true;
        triggeredOnStart: true;

        onTriggered: {
            if (api.memory.get('twelveHour') === true) {
                clock.text = Qt.formatTime(new Date(), 'h:mm ap');
            } else {
                clock.text = Qt.formatTime(new Date(), 'hh:mm');
            }
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
            if (api.memory.get('twelveHour') === undefined) {
                api.memory.set('twelveHour', false);
            }

            clockTimer.start();
        }

        MouseArea {
            anchors {
                fill: parent;
            }

            onClicked: {
                api.memory.set('twelveHour', !api.memory.get('twelveHour'));
                clockTimer.restart();
            }
        }
    }
}
