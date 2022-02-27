import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onUpPressed: {
        const prevIndex = settingsScroll.settingsListView.currentIndex;
        event.accepted = true;
        settingsScroll.settingsListView.decrementCurrentIndex();
        const currentIndex = settingsScroll.settingsListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    Keys.onDownPressed: {
        const prevIndex = settingsScroll.settingsListView.currentIndex;
        event.accepted = true;
        settingsScroll.settingsListView.incrementCurrentIndex();
        const currentIndex = settingsScroll.settingsListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    function onAcceptPressed() {
        const currentIndex = settingsScroll.settingsListView.currentIndex;
        const currentKey = settings.keys[currentIndex];
        settings.toggle(currentKey);
        sounds.nav();
    }

    function onCancelPressed() {
        currentView = previousView;
        sounds.back();
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            onCancelPressed();
        }
    }

    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    SettingsScroll {
        id: settingsScroll;

        anchors {
            top: settingsHeader.bottom;
            bottom: settingsFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: settingsFooter;

        total: 0;

        buttons: [
            { title: 'Toggle', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
        }
    }

    Header.Component {
        id: settingsHeader;

        showDivider: true;
        shade: 'dark';
        color: theme.current.bgColor;
        showTitle: true;
        title: 'Settings';
    }
}
