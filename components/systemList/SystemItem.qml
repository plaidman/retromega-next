import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../resources' as Resources

Item {
    id: lvDelegateItem;

    function letterSpacing(str) {
        return str === 'NES' ? 1.0 : -1.0;
    }

    function systemCompany(shortName) {
        return systemData.systemCompanies[shortName] ?? '';
    }

    Resources.SystemData { id: systemData; }

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
