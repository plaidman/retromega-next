import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property alias backSound: backSound;
    property alias forwardSound: forwardSound;
    property alias navSound: navSound;
    property alias launchSound: launchSound;
    property alias startSound: startSound;

    SoundEffect {
        id: backSound;
        source: '../../assets/sound/sound-back.wav';
        volume: 0.5;
    }

    SoundEffect {
        id: forwardSound;
        source: '../../assets/sound/sound-forward.wav';
        volume: 0.5;
    }

    SoundEffect {
        id: navSound;
        source: '../../assets/sound/sound-click.wav';
        volume: 1.0;
    }

    SoundEffect {
        id: launchSound;
        source: '../../assets/sound/sound-launch.wav';
        volume: 0.35;
    }

    SoundEffect {
        id: startSound;
        source: '../../assets/sound/sound-start.wav';
        volume: 0.35;
    }
}
