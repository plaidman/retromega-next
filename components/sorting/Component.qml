import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onUpPressed: {
        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.decrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    Keys.onDownPressed: {
        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.incrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    function onAcceptPressed() {
        const currentKey = sorting.model.get(sortingScroll.sortingListView.currentIndex).key;
        sorting.executeCallback(currentKey);
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
    }

    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    SortingScroll {
        id: sortingScroll;

        anchors {
            top: sortingHeader.bottom;
            bottom: sortingFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: sortingFooter;

        total: 0;

        buttons: [
            { title: 'Toggle', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
        ];

        onFooterButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
        }
    }

    Header.Component {
        id: sortingHeader;

        showDivider: true;
        shade: 'dark';
        color: theme.current.bgColor;
        showTitle: true;
        title: 'Sorting and Filters';
    }
}
