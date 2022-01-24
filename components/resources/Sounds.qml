import QtQuick 2.15
import QtMultimedia 5.9

Item {
    function back() { backSound.play(); }
    function forward() { forwardSound.play(); }
    function nav() { navSound.play(); }
    function launch() { launchSound.play(); }
    function start() { startSound.play(); }

    SoundEffect {
        id: backSound;
        source: '../../assets/sound/back.wav';
        volume: 0.5;
    }

    SoundEffect {
        id: forwardSound;
        source: '../../assets/sound/forward.wav';
        volume: 0.5;
    }

    SoundEffect {
        id: navSound;
        source: '../../assets/sound/click.wav';
        volume: 1.0;
    }

    SoundEffect {
        id: launchSound;
        source: '../../assets/sound/launch.wav';
        volume: 0.35;
    }

    SoundEffect {
        id: startSound;
        source: '../../assets/sound/start.wav';
        volume: 0.35;
    }
}
