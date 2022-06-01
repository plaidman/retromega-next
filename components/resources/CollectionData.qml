import QtQuick 2.15

Item {
    function getColor(shortName) {
        const alias = getAlias(shortName);
        return collectionData.metadata[alias].color
            ?? collectionData.metadata['default'].color;
    }

    function getVendorYear(shortName) {
        const alias = getAlias(shortName);
        const vendor = collectionData.metadata[alias].vendor ?? '';
        const year = collectionData.metadata[alias].year ?? '';

        return [vendor, year]
            .filter(v => { return v !== '' })
            .join(' • ');
    }

    function getImage(shortName) {
        const alias = getAlias(shortName);
        if (alias === 'default') return shortName;
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
        'jaguar': 'atarijaguar',
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
        'msdos': 'dos',
        'virtualboy': 'vboy',
        'ps1': 'psx',
        'megacd': 'segacd',
        'mega32x': 'sega32x',
        'x68k': 'x68000',
        'dc': 'dreamcast',
        'md': 'genesis',
        'supernes': 'snes',
        'sfc': 'snes',
        'superfc': 'snes',
        'famicom': 'nes',
        'fc': 'nes',
        'wonderswan': 'wswan',
        'wonderswancolor': 'wswanc',
        'wonderswanc': 'wswanc',
    }

    property var metadata: {
        '3do': { color: '#afdb69', vendor: 'The 3DO Company', year: '1993-1996' },
        '3ds': { color: '#73bc9e', vendor: 'Nintendo', year: '2011-2020' },
        'allgames': { color: '#292463' },
        'amiga': { color: '#724755', vendor: 'Commodore', year: '1985-1996' },
        'android': { color: '#266f4f' },
        'arcade': { color: '#528821' },
        'atari2600': { color: '#4f7524', vendor: 'Atari', year: '1977-1992' },
        'atari5200': { color: '#0685bb', vendor: 'Atari', year: '1982-1984' },
        'atari7800': { color: '#1d4b4c', vendor: 'Atari', year: '1986-1992' },
        'atarijaguar': { color: '#af4bec', vendor: 'Atari', year: '1993-1996' },
        'atomiswave': { color: '#025669', vendor: 'Sammy', image: 'arcade', year: '2003-2009' },
        'c64': { color: '#9d4083', vendor: 'Commodore', year: '1982-1994' },
        'colecovision': { color: '#f9182f', vendor: 'Coleco', year: '1982-1985' },
        'dos': { color: '#87151b', vendor: 'Microsoft', year: '1981-2000' },
        'dreamcast': { color: '#2387ff', vendor: 'Sega', year: '1998-2001' },
        'favorites': { color: '#b75057' },
        'gamecube': { color: '#4b0082', vendor: 'Nintendo', year: '2001-2007' },
        'gamegear': { color: '#d0970d', vendor: 'Sega', year: '1990-1997' },
        'gb': { color: '#9f75b0', vendor: 'Nintendo', year: '1989-2003' },
        'gba': { color: '#342692', vendor: 'Nintendo', year: '2001-2008' },
        'gbc': { color: '#7b4ccc', vendor: 'Nintendo', year: '1998-2003' },
        'genesis': { color: '#df535b', vendor: 'Sega', year: '1988-1997' },
        'intellivision': { color: '#4566f5', vendor: 'Mattel', year: '1979-1990' },
        'lynx': { color: '#4c9141', vendor: 'Atari', year: '1989-1995' },
        'mastersystem': { color: '#2f34c2', vendor: 'Sega', year: '1985-1996' },
        'msx': { color: '#ef3208', vendor: 'Microsoft', year: '1983-1993' },
        'n64': { color: '#807c68', vendor: 'Nintendo', year: '1996-2002' },
        'naomi': { color: '#843c8a', vendor: 'Sega', year: '1998-2001' },
        'nds': { color: '#d09826', vendor: 'Nintendo', year: '2004-2013' },
        'neogeo': { color: '#1499de', vendor: 'SNK', year: '1990-2004' },
        'neogeocd': { color: '#9e5c27', vendor: 'SNK', year: '1994-1997' },
        'nes': { color: '#c85173', vendor: 'Nintendo', year: '1983-2003' },
        'ngp': { color: '#b32428', vendor: 'SNK', year: '1998-2001' },
        'odyssey2': { color: '#9b276d', vendor: 'Magnavox', year: '1978-1984' },
        'pcengine': { color: '#25482b', vendor: 'NEC', year: '1987-1994' },
        'pico8': { color: '#1c542d', vendor: 'Lexaloffle', year: '2015' },
        'pokemini': { color: '#19b091', vendor: 'Nintendo', year: '2001-2002' },
        'ports': { color: '#1d334a' },
        'ps2': { color: '#347867', vendor: 'Sony', year: '2000-2013' },
        'psp': { color: '#4e0b9c', vendor: 'Sony', year: '2004-2014' },
        'psx': { color: '#365f8d', vendor: 'Sony', year: '1994-2006' },
        'recents': { color: '#906226', vendor: 'past 30 days' },
        'saturn': { color: '#5b92ff', vendor: 'Sega', year: '1994-2000' },
        'scummvm': { color: '#5bce20', vendor: 'Lucasfilm Games', year: '1987-1998' },
        'sega32x': { color: '#6935e9', vendor: 'Sega', image: 'segacd', year: '1994-1996' },
        'segacd': { color: '#cc4545', vendor: 'Sega', year: '1991-1996' },
        'snes': { color: '#aa6aff', vendor: 'Nintendo', year: '1990-2003' },
        'vboy': { color: '#802325', vendor: 'Nintendo', year: '1995-1996' },
        'vectrex': { color: '#8129f1', vendor: 'Milton Bradley', year: '1982-1984' },
        'wii': { color: '#e0e027', vendor: 'Nintendo', year: '2006-2017' },
        'wswan': { color: '#d38aba', vendor: 'Bandai', year: '1999-2003' },
        'wswanc': { color: '#9b3f23', vendor: 'Bandai', image: 'wswan', year: '1999-2003' },
        'x68000': { color: '#a53180', vendor: 'Sharp', year: '1987-1993' },
        'zxspectrum': { color: '#0c46a9', vendor: 'Sinclair', year: '1982-1992' },
        'default': { color: '#194492' },
    };
}
