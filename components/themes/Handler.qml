import QtQuick 2.15

Item {
    property Item current: lightTheme;

    function setDarkMode(value) {
        if (value) {
            current = darkTheme;
        } else {
            current = lightTheme;
        }
    }

    Component.onCompleted: {
        settings.addCallback('darkMode', setDarkMode);
    }

    LightTheme { id: lightTheme; }
    DarkTheme { id: darkTheme; }
}
