import QtQuick 2.15

Item {
    property Item current: lightTheme;
    property Item buttonGuide: switchButtons;
    property double fontScale: 1.0;

    function setFontScale(smallFont) {
        if (smallFont) {
            fontScale = 0.5;
        } else {
            fontScale = 1.0;
        }
    }

    function setDarkMode(value) {
        if (value) {
            current = darkTheme;
        } else {
            current = lightTheme;
        }
    }

    function setButtonGuide(value) {
        if (value) {
            buttonGuide = xboxButtons;
        } else {
            buttonGuide = switchButtons;
        }
    }

    Component.onCompleted: {
        settings.addCallback('darkMode', setDarkMode);
        settings.addCallback('buttonGuide', setButtonGuide);
        settings.addCallback('smallFont', setFontScale);
    }

    LightTheme { id: lightTheme; }
    DarkTheme { id: darkTheme; }
    SwitchButtons { id: switchButtons; }
    XboxButtons { id: xboxButtons; }
}
