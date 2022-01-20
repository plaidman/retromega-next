import QtQuick 2.15

import 'components/systemList' as SystemList
import 'components/gameList' as GameList
import 'components/gameDetail' as GameDetail

// todo list:
//   [o] system list
//     [ ] # of total in footer
//     [ ] touch support
//     [ ] controller support
//     [ ] break up systemscroll.qml
//     [ ] better system name font spacing
//     [ ] rename all 'system' to collection
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

//   [ ] ps2 controller
//   [ ] wii controller
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
    property int currentCollection: 0;
    property int currentGame: 0;

    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'systemList';
        currentCollection = api.memory.get('currentCollection') ?? 0;
        currentGame = api.memory.get('currentGame') ?? 0;
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollection', currentCollection);
        api.memory.set('currentGame', currentGame);
    }

    Rectangle {
        x: 200;
        width: 640;
        height: 480;

        SystemList.Component {
            visible: currentView === 'systemList';
            focus: currentView === 'systemList';
        }

        GameList.Component {
            visible: currentView === 'gameList';
            focus: currentView === 'gameList';
        }

        GameDetail.Component {
            visible: currentView === 'gameDetail';
            focus: currentView === 'gameDetail';
        }

        Rectangle {
            x: 100;
            y: 100;
            width: debug.width + 10;
            height: debug.height + 10;

            color: 'black';
            border.color: 'white';

            Text {
                id: debug;

                text: 'debug';
                color: 'magenta';
                anchors.centerIn: parent;
            }
        }
    }
}
