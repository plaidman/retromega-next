import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;
    property bool nameFilterShowing: false;

    function showModal() {
        nameFilterShowing = true;
        nameFilterModal.anchors.topMargin = 0;
        nameFilterModal.textInput.text = nameFilter;
    }

    function hideModal() {
        nameFilterShowing = false;
        nameFilterModal.anchors.topMargin = root.height;
    }

    Keys.onUpPressed: {
        if (nameFilterShowing) return;

        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.decrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    Keys.onDownPressed: {
        if (nameFilterShowing) return;

        const prevIndex = sortingScroll.sortingListView.currentIndex;
        event.accepted = true;
        sortingScroll.sortingListView.incrementCurrentIndex();
        const currentIndex = sortingScroll.sortingListView.currentIndex;

        if (currentIndex !== prevIndex) {
            sounds.nav();
        }
    }

    function onAcceptPressed(muteSound = false) {
        if (nameFilterShowing) {
            nameFilter = nameFilterModal.textInput.text;
            hideModal();
            sounds.forward();
            return;
        }

        const currentKey = sorting.model.get(sortingScroll.sortingListView.currentIndex).key;
        sorting.executeCallback(currentKey);
        if (!muteSound) sounds.nav();
    }

    function onCancelPressed() {
        if (nameFilterShowing) {
            hideModal();
            sounds.back();
            return;
        };

        updateGameIndex(0, true);
        currentView = previousView;
        sounds.back();
    }

    function onClearPressed() {
        if (!nameFilterShowing) return;

        nameFilterModal.textInput.clear();
        onAcceptPressed();
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
            onClearPressed();
        }
    }

    Item {
        id: allDetailsBlur;

        anchors.fill: parent;

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
                { title: 'Toggle', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: 'Back', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
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
            showSettings: false;
            color: theme.current.bgColor;
            showTitle: true;
            title: 'Sorting and Filters';
        }
    }

    NameFilterModal {
        id: nameFilterModal;

        height: parent.height;
        width: parent.width;
        blurSource: allDetailsBlur;

        anchors {
            top: parent.top;
            topMargin: root.height;
            left: parent.left;
            right: parent.right;
        }

        Behavior on anchors.topMargin {
            PropertyAnimation { easing.type: Easing.OutCubic; duration: 200; }
        }
    }
}
