import QtQuick 2.15

Item {
    property string shade: 'light';
    property string shadeColor: {
        return shade === 'light'
            ? theme.current.sortColorLight
            : theme.current.sortColorDark;
    }

    property string buttonColor: {
        return shade === 'light'
            ? theme.current.sortButtonColorLight
            : theme.current.sortButtonColorDark;
    }

    property string label: {
        if (sortKey === 'sortBy') return 'title';
        if (sortKey === 'lastPlayed') return 'recent';
        return sortKey;
    }

    property string filter: {
        if (nameFilter === '') return '';
        if (nameFilter.length > 4) return ':' + nameFilter.substring(0,3) + '…';
        return ':' + nameFilter;
    }

    property string icon: {
        if (sortDir === Qt.AscendingOrder) return glyphs.ascend;
        return glyphs.descend;
    }

    width: buttonRect.width + sortRow.width + parent.height * .3;

    Rectangle {
        id: sortRect;

        color: 'transparent';
        border.color: shadeColor;
        radius: parent.height * .2;
        anchors.verticalCenter: parent.verticalCenter;

        anchors {
            verticalCenter: parent.verticalCenter;
            fill: parent;
        }

        Rectangle {
            id: buttonRect;

            color: shadeColor;
            radius: parent.radius - 1;
            height: parent.height - 2;
            width: buttonText.width + parent.height * .4;

            anchors {
                left: parent.left;
                leftMargin: 1;
                top: parent.top;
                topMargin: 1;
            }

            Text {
                id: buttonText;
                text: theme.buttonGuide.pageDown;
                color: buttonColor;

                anchors {
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: parent.height * .2;
                }

                font {
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }
        }

        Row {
            id: sortRow;

            spacing: parent.height * .25;
            height: parent.height;

            anchors {
                verticalCenter: parent.verticalCenter;
                left: buttonRect.right;
                leftMargin: parent.height * .25;
            }

            Text {
                id: sortingIcon;

                text: icon;
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter;
                color: shadeColor;

                font {
                    family: glyphs.name;
                    pixelSize: parent.height * .5;
                }
            }

            Text {
                id: labelText;

                text: label + filter;
                color: shadeColor;
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter;

                font {
                    pixelSize: parent.height * .7;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }

            Text {
                id: favoritesIcon;

                visible: onlyFavorites;
                text: glyphs.favorite;
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter;
                color: shadeColor;

                font {
                    family: glyphs.name;
                    pixelSize: parent.height * .5;
                }
            }
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (currentView === 'sorting') {
                    currentView = previousView;
                    sounds.back();
                } else {
                    previousView = currentView;
                    currentView = 'sorting';
                    sounds.forward();
                }
            }
        }
    }
}
