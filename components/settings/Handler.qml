import QtQuick 2.15

Item {
    property var keys: [
        'bgMusic', 'navSounds', 'darkMode', 'buttonGuide', 'twelveHour',
        'smallFont', 'gameListVideo', 'gameDetailsVideo', 'quietVideo',
        'quickVideo', 'dropShadow', 'resetNameFilter', 'attractTitle',
        'favoritesOnTop', 'delayedImage', 'showAllGames', 'showRecents', 'showFavorites'
    ];

    function title(key) { return titles[key]; }
    function toggle(key) { set(key, !values[key]); }

    function get(key) {
        if (values[key] === null) {
            set(key, api.memory.get(key) ?? defaults[key]);
        }

        return values[key];
    }

    function saveAll() {
        for (const key of keys) {
            api.memory.set(key, get(key));
        }
    }

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

    property var defaults: {
        'bgMusic': true,
        'navSounds': true,
        'darkMode': false,
        'buttonGuide': false,
        'twelveHour': false,
        'smallFont': false,
        'gameListVideo': true,
        'gameDetailsVideo': true,
        'quietVideo': false,
        'quickVideo': false,
        'dropShadow': true,
        'resetNameFilter': false,
        'attractTitle': true,
        'favoritesOnTop': false,
        'delayedImage': false,
		'showAllGames': true,
		'showRecents': true,
		'showFavorites': true,
    }

    property var values: {
        'bgMusic': null,
        'navSounds': null,
        'darkMode': null,
        'buttonGuide': null,
        'twelveHour': null,
        'smallFont': null,
        'gameListVideo': null,
        'gameDetailsVideo': null,
        'quietVideo': null,
        'quickVideo': null,
        'dropShadow': null,
        'resetNameFilter': null,
        'attractTitle': null,
        'favoritesOnTop': null,
        'delayedImage': null,
		'showAllGames': null,
		'showRecents': null,
		'showFavorites': null,
    }

    property var callbacks: {
        'bgMusic': [],
        'navSounds': [],
        'darkMode': [],
        'buttonGuide': [],
        'twelveHour': [],
        'smallFont': [],
        'gameListVideo': [],
        'gameDetailsVideo': [],
        'quietVideo': [],
        'quickVideo': [],
        'dropShadow': [],
        'resetNameFilter': [],
        'attractTitle': [],
        'favoritesOnTop': [],
        'delayedImage': [],
		'showAllGames': [],
		'showRecents': [],
		'showFavorites': [],
    }

    property var titles: {
        'bgMusic': 'Background Music',
        'navSounds': 'Navigation Sounds',
        'darkMode': 'Dark Theme',
        'buttonGuide': 'XBox Button Guide',
        'twelveHour': 'Twelve Hour Clock',
        'smallFont': 'Use Smaller Font',
        'gameListVideo': 'Video On Game List',
        'gameDetailsVideo': 'Video On Game Details',
        'quietVideo': 'Silent Videos',
        'quickVideo': 'Shorter Video Delay',
        'dropShadow': 'Enable Video/Image Shadow',
        'resetNameFilter': 'Clear Name Filter On Reload',
        'attractTitle': 'Game Title On Attract Mode',
        'favoritesOnTop': 'Favorites On Top',
        'delayedImage': 'Delayed Images',
		'showAllGames': 'Show All Games Collection',
		'showRecents': 'Show Last Played Collection',
		'showFavorites': 'Show Favorites Collection',
    }
}
