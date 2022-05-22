import QtQuick 2.15
import Qt.labs.qmlmodels 1.0

Item {
    property alias sortingListView: sortingListView;
    property double itemHeight: {
        return sortingListView.height * .16 * theme.fontScale;
    }

    Component.onCompleted: {
        sortingListView.currentIndex = 0;
        sortingListView.positionViewAtIndex(0, ListView.Center);
    }

    ListView {
        id: sortingListView;

        model: sorting.model;
        delegate: lvSortingDelegate;
        width: parent.width - 40; // minus the margins
        height: parent.height - 24;
        highlightMoveDuration: 0;
        preferredHighlightBegin: itemHeight - 12; // height of an item minus top margin
        preferredHighlightEnd: parent.height - (itemHeight + 12); // height of an item plus bottom margin
        highlightRangeMode: ListView.ApplyRange;

        anchors {
            left: parent.left;
            leftMargin: 20;
            top: parent.top;
            topMargin: 12;
            bottom: parent.bottom;
            bottomMargin: 12;
            right: parent.right;
            rightMargin: 20;
        }

        highlight: Rectangle {
            color: theme.current.highlightColor;
            radius: 8;
            width: sortingListView.width;
        }
    }

    DelegateChooser {
        id: lvSortingDelegate;
        role: 'type';

        DelegateChoice {
            roleValue: 'sort';

            SortingItem {
                width: sortingListView.width;
                height: itemHeight;
            }
        }

        DelegateChoice {
            roleValue: 'onlyFavorites';

            ToggleItem {
                width: sortingListView.width;
                height: itemHeight;
                value: onlyFavorites;
            }
        }

        DelegateChoice {
            roleValue: 'onlyMultiplayer';

            ToggleItem {
                width: sortingListView.width;
                height: itemHeight;
                value: onlyMultiplayer;
            }
        }

        DelegateChoice {
            roleValue: 'nameFilter';

            NameFilterItem {
                width: sortingListView.width;
                height: itemHeight;
            }
        }
    }
}
