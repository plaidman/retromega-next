import QtQuick 2.15

Item {
    width: clock.width;
    height: clock.height;

    property bool lightText: true;
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
        color: lightText ? '#80ffffff' : '#80000000';

        font {
            pixelSize: 18;
            letterSpacing: -0.3;
            bold: true;
        }

        Component.onCompleted: {
            twelveHour = api.memory.get('twelveHour') ?? false;
            clockTimer.start();
        }

        Component.onDestruction: {
            api.memory.set('twelveHour', twelveHour);
        }

        MouseArea {
            anchors {
                fill: parent;
            }

            onClicked: {
                twelveHour = !twelveHour;
                clockTimer.restart();
            }
        }
    }
}
