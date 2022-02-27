import QtQuick 2.15
import QtMultimedia 5.9

Item {
    property var keys: ['bgMusic', 'navSounds', 'darkMode', 'twelveHour', 'smallFont', 'gameListVideo'];

    function get(key) { return values[key]; }
    function title(key) { return titles[key]; }
    function toggle(key) { set(key, !values[key]); }

    function set(key, value) {
        if (values[key] === undefined) return;

        values[key] = value;
        callback(key);
    }

    function addCallback(key, callback) {
        if (callbacks[key] === undefined) return;

        callbacks[key].push(callback);
    }

    function callback(key) {
        if (callbacks[key] === undefined) return;

        for (let i = 0; i < callbacks[key].length; i++) {
            callbacks[key][i](values[key]);
        }
    }

    property var values: {
        'bgMusic': true,
        'navSounds': true,
        'darkMode': false,
        'twelveHour': false,
        'smallFont': false,
        'gameListVideo': true,
    }

    property var callbacks: {
        'bgMusic': [],
        'navSounds': [],
        'darkMode': [],
        'twelveHour': [],
        'smallFont': [],
        'gameListVideo': [],
    }

    property var titles: {
        'bgMusic': 'Background Music',
        'navSounds': 'Navigation Sounds',
        'darkMode': 'Dark Theme',
        'twelveHour': 'Twelve Hour Clock',
        'smallFont': 'Use Smaller Font',
        'gameListVideo': 'Video On Game List',
    }
}
