import QtQuick 2.15

Item {
    function getColor(shortName) {
        const alias = getAlias(shortName);
        return collectionData.metadata[alias].color
            ?? collectionData.metadata['default'].color;
    }

    function getVendor(shortName) {
        const alias = getAlias(shortName);
        return collectionData.metadata[alias].vendor ?? '';
    }

    function getImage(shortName) {
        const alias = getAlias(shortName);
        if (alias === 'default') alias = shortName;
        return collectionData.metadata[alias].image ?? alias;
    }

    function getAlias(shortName) {
        if (aliases[shortName] !== undefined) return aliases[shortName];
        if (metadata[shortName] !== undefined) return shortName;
        return 'default'
    }

    property var aliases: {
        'megadrive': 'genesis',
        'gc': 'gamecube',
        'mame': 'arcade',
        'fba': 'arcade',
        'fbneo': 'arcade',
        'fbn': 'arcade',
        'ngpc': 'ngp',
        'tg16': 'pcengine',
        'tg16cd': 'pcengine',
        'turbografx16': 'pcengine',
        'turbografx16cd': 'pcengine',
        'pcenginecd': 'pcengine',
        'pce': 'pcengine',
        'pcecd': 'pcengine',
        'atarilynx': 'lynx',
        'gameboy': 'gb',
        'vb': 'vboy',
        'virtualboy': 'vboy',
        'ps1': 'psx',
        'megacd': 'segacd',
        'mega32x': 'sega32x',
        'dc': 'dreamcast',
        'md': 'genesis',
        'supernes': 'snes',
        'wonderswan': 'wswan',
        'wonderswancolor': 'wswanc',
        'wonderswanc': 'wswanc',
    }

    property var metadata: {
        '3ds': { color: '#73bc9e', vendor: 'Nintendo' },
        'allgames': { color: '#292463' },
        'android': { color: '#266f4f' },
        'arcade': { color: '#528821' },
        'atomiswave': { color: '#025669', vendor: 'Sammy', image: 'arcade' },
        'dreamcast': { color: '#2387ff', vendor: 'Sega' },
        'favorites': { color: '#b75057' },
        'gamecube': { color: '#4b0082', vendor: 'Nintendo' },
        'gamegear': { color: '#d0970d', vendor: 'Sega' },
        'gb': { color: '#9f75b0', vendor: 'Nintendo' },
        'gba': { color: '#342692', vendor: 'Nintendo' },
        'gbc': { color: '#7b4ccc', vendor: 'Nintendo' },
        'genesis': { color: '#df535b', vendor: 'Sega' },
        'lynx': { color: '#4c9141', vendor: 'Atari' },
        'mastersystem': { color: '#2f34c2', vendor: 'Sega' },
        'n64': { color: '#807c68', vendor: 'Nintendo' },
        'nds': { color: '#d09826', vendor: 'Nintendo' },
        'neogeo': { color: '#1499de', vendor: 'SNK' },
        'neogeocd': { color: '#9e5c27', vendor: 'SNK' },
        'nes': { color: '#c85173', vendor: 'Nintendo' },
        'ngp': { color: '#aa6aff', vendor: 'SNK' }, // same color as snes
        'pcengine': { color: '#25482b', vendor: 'NEC' },
        'pico8': { color: '#1c542d', vendor: 'Lexaloffle' },
        'pokemini': { color: '#19b091', vendor: 'Nintendo' },
        'ports': { color: '#1d334a' },
        'ps2': { color: '#347867', vendor: 'Sony' },
        'psp': { color: '#4e0b9c', vendor: 'Sony' },
        'psx': { color: '#365f8d', vendor: 'Sony' },
        'recents': { color: '#906226' },
        'saturn': { color: '#5b92ff', vendor: 'Sega' },
        'sega32x': { color: '#6935e9', vendor: 'Sega', image: 'segacd' },
        'segacd': { color: '#cc4545', vendor: 'Sega' },
        'snes': { color: '#aa6aff', vendor: 'Nintendo' }, // same color as ngp
        'vboy': { color: '#802325', vendor: 'Nintendo' },
        'wii': { color: '#e0e027', vendor: 'Nintendo' },
        'wswan': { color: '#d38aba', vendor: 'Bandai' },
        'wswanc': { color: '#9b3f23', vendor: 'Bandai', image: 'wswan' },
        'default': { color: '#194492' },
    };
}
