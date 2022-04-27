import QtQuick 2.15

Item {
    property string shade: 'light';
    property string shadeColor: {
        return shade === 'light'
            ? theme.current.clockColorLight
            : theme.current.clockColorDark;
    }

    width: clockText.width;

    Component.onCompleted: {
        clockTimer.start();
        settings.addCallback('twelveHour', clockTimer.restart);
    }

    Timer {
        id: clockTimer;

        interval: 30000;
        repeat: true;
        triggeredOnStart: true;

        onTriggered: {
            let format = 'hh:mm';

            if (settings.get('twelveHour')) {
                format = 'h:mm ap';
            }

            clockText.text = Qt.formatTime(new Date(), format);
        }
    }

    Text {
        id: clockText;

        text: '00:00';
        color: shadeColor;

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
            }
        }
    }
}
