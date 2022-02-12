import QtQuick 2.15

Item {
    property string theme: 'light';
    property string themeColor: {
        return theme === 'light' ? '#80ffffff' : '#80000000';
    }
    property bool twelveHour: false;
    property string timeFormat: {
        return twelveHour ? 'h:mm ap' : 'hh:mm';
    };

    width: clock.width;

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
        color: themeColor;

        anchors.verticalCenter: parent.verticalCenter;

        font {
            pixelSize: parent.height * .33;
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
            anchors.fill: parent;

            onClicked: {
                twelveHour = !twelveHour;
                clockTimer.restart();
            }
        }
    }
}
