import QtQuick 2.15

import 'components/systemList' as SystemList
import 'components/gameList' as GameList
import 'components/gameDetail' as GameDetail

// todo list:
//   [ ] system list
//   [ ] game list
//   [ ] game detail

//   [o] footer
//     [x] buttons
//     [ ] # of total label
//   [o] header
//     [x] real time battery
//     [x] real time clock
//     [x] tap to switch 24 hour
//     [ ] title

//   [ ] remove duplicate colors
//   [ ] navigation sounds
//   [ ] all/favorites/recents/apps
//   [ ] random select
//   [ ] alphabetic index
//   [ ] filter/sort modal
//   [ ] touch
//   [ ] dark mode
//   [ ] bg music
//     [ ] button to stop
//   [ ] filterable android apps

FocusScope {
    property string currentView: 'systemList';

    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'systemList';
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
    }

    Rectangle {
        width: 640;
        height: 480;

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                const nextView = {
                    systemList: 'gameList',
                    gameList: 'gameDetail',
                    gameDetail: 'systemList',
                };
                currentView = nextView[currentView] ?? 'systemList';
            }
        }

        SystemList.Component {
            visible: currentView === 'systemList';
        }

        GameList.Component {
            visible: currentView === 'gameList';
        }

        GameDetail.Component {
            visible: currentView === 'gameDetail';
        }
    }
}
