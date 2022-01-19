import QtQuick 2.15
import QtGraphicalEffects 1.12

Rectangle {
    property int collectionCount: api.collections.count;

    function letterSpacing(str) {
        return str === 'NES' ? 1.0 : -1.0;
    }

    function systemColor(index) {
        const system = api.collections.get(index);
        const shortName = system.shortName ?? 'default';
        return systemData.systemColors[shortName] ?? systemData.systemColors['default'];
    }

    function systemCompany(shortName) {
        return systemData.systemCompanies[shortName] ?? '';
    }

    Component.onCompleted: {
        systemsListView.currentIndex = api.memory.get('systemIndex') ?? 0;
        systemsListView.positionViewAtIndex(systemsListView.currentIndex, ListView.Center);

        backgroundColor.color = systemColor(systemsListView.currentIndex);
    }

    Component.onDestruction: {
        api.memory.set('systemIndex', systemsListView.currentIndex);
    }

    SystemData { id: systemData; }

    // background color, fades when system changes
    Rectangle {
        id: backgroundColor;

        width: parent.width;
        height: parent.height;
        color: 'transparent';

        Behavior on color {
            ColorAnimation {
                duration: 335;
                easing.type: Easing.InOutQuad;
            }
        }
    }

    // dots
    PageIndicator {
        currentIndex: systemsListView.currentIndex;
        pageCount: collectionCount;

        anchors {
            horizontalCenter: parent.horizontalCenter;
            bottom: parent.bottom;
            bottomMargin: 25;
        }
    }

    ListView {
        id: systemsListView;

        model: api.collections;
        delegate: lvDelegate;
        cacheBuffer: 10;
        orientation: ListView.Horizontal;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        preferredHighlightBegin: 0;
        preferredHighlightEnd: parent.width;
        snapMode: ListView.SnapToItem;
        highlightMoveDuration: 225;
        highlightMoveVelocity: -1;
        spacing: 50;

        onCurrentIndexChanged: {
            backgroundColor.color = systemColor(currentIndex);
        }

        anchors {
            fill: parent;
        }
    }

    Component {
        id: lvDelegate;

        Item {
            id: lvDelegateItem;

            width: systemsListView.width;
            height: systemsListView.height;

            // background stripe
            Image {
                source: '../../assets/images/menu-side-2.png';
                fillMode: Image.PreserveAspectFit;
                height: parent.height;

                anchors {
                    top: parent.top;
                    right: parent.right;
                    rightMargin: 70;
                }
            }

            Text {
                id: title;

                text: name;
                color: '#ffffff';
                width: 300;
                wrapMode: Text.WordWrap;
                lineHeight: 0.8;

                font {
                    pixelSize: 36;
                    letterSpacing: letterSpacing(name);
                    bold: true;
                }

                anchors {
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 30;
                    verticalCenterOffset: -5;
                }
            }

            DropShadow {
                source: title;
                verticalOffset: 10;
                color: '#20000000';
                radius: 20;
                samples: 10;

                anchors {
                    fill: title;
                }
            }

            Text {
                text: games.count + ' games';
                color: '#ffffff';
                opacity: 0.7;

                anchors {
                    left: parent.left;
                    leftMargin: 30;
                    top: title.bottom;
                    topMargin: 10;
                }

                font {
                    pixelSize: 14;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }

            Text {
                text: systemCompany(shortName).toUpperCase();
                color: '#ffffff';
                opacity: 0.7;

                font {
                    pixelSize: 12;
                    letterSpacing: 1.3;
                    bold: true;
                }

                anchors {
                    left: parent.left;
                    leftMargin: 30;
                    bottom: title.top;
                    bottomMargin: -1;
                }
            }

            Image {
                id: device;

                source: '../../assets/images/devices/' + shortName + '.png';
                cache: true;
                asynchronous: true;

                anchors {
                    verticalCenter: parent.verticalCenter;
                    verticalCenterOffset: 10;
                    right: parent.right;
                    rightMargin: 0;
                }

                states: [
                    State {
                        name: "active";
                        when: lvDelegateItem.ListView.isCurrentItem;
                        PropertyChanges { target: device; anchors.rightMargin: -60.0; }
                    },
                    State {
                        name: "inactiveRight";
                        when: !lvDelegateItem.ListView.isCurrentItem && systemsListView.currentIndex < index;
                        PropertyChanges { target: device; anchors.rightMargin: -160.0; }
                    },
                    State {
                        name: "inactiveLeft";
                        when: !lvDelegateItem.ListView.isCurrentItem && systemsListView.currentIndex > index;
                        PropertyChanges { target: device; anchors.rightMargin: 40.0; }
                    }
                ]

                transitions: Transition {
                    NumberAnimation { properties: 'anchors.rightMargin'; easing.type: Easing.InOutCubic; duration: 225  }
                }
            }
        }
    }
}
