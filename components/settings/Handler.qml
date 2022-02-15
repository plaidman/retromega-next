import QtQuick 2.15
import QtMultimedia 5.9

Item {
    function get(key) { return values[key]; }
    function title(key) { return titles[key]; }
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

    function save() {
        api.memory.set('bgMusic', values.bgMusic);
        api.memory.set('navSounds', values.navSounds);
        api.memory.set('darkMode', values.darkMode);
        api.memory.set('twelveHour', values.twelveHour);
    }

    Component.onCompleted: {
        values.bgMusic = api.memory.get('bgMusic') ?? true;
        values.navSounds = api.memory.get('bgMusic') ?? true;
        values.darkMode = api.memory.get('bgMusic') ?? true;
        values.twelveHour = api.memory.get('bgMusic') ?? true;
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
