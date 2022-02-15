import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property var keys: ['bgMusic', 'navSounds', 'darkMode', 'twelveHour'];

    function toggle(key) { set(key, !values[key]); }
    function set(key, value) {
        if (values[key] === undefined) return;

        values[key] = value;
        callback(key);
    }

    function callback(key) {
        if (callbacks[key] === undefined) return;

        callbacks[key]();
    }

    property var values: {
        'bgMusic': true,
        'navSounds': true,
        'darkMode': false,
        'twelveHour': false,
    }

    property var callbacks: {
        'bgMusic': function () {
            if (values.bgMusic) {
                music.shuffle();
                music.play();
            } else {
                music.stop();
            }
        },
    }

    property var titles: {
        'bgMusic': 'Background Music',
        'navSounds': 'Navigation Sounds',
        'darkMode': 'Dark Theme',
        'twelveHour': 'Twelve Hour Clock',
    }
}
