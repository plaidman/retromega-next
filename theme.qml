import QtQuick 2.15

import 'components/systemList' as SystemList
import 'components/gameList' as GameList
import 'components/gameDetail' as GameDetail
import 'components/footer' as Footer

// todo list:
//   system list
//   game list
//   detail screen

//   real time battery
//   real time clock

//   navigation sounds
//   all/favorites/recents/apps
//   random select
//   alphabetic index
//   filter/sort modal
//   touch
//   dark mode
//   bg music

FocusScope {
    property string currentView: 'systemList';

    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'systemList';
    }

    Rectangle {
        width: 640;
        height: 480;

        SystemList.Component {
            visible: currentView === 'systemList';
        }

        GameList.Component {
            visible: currentView === 'gameList';
        }

        GameDetail.Component {
            visible: currentView === 'gameDetail';
        }

        Footer.Component {}

        MouseArea {
            anchors.fill: parent;

            onClicked: {
                switch (currentView) {
                    case 'systemList':
                        currentView = 'gameList';
                        break;

                    case 'gameList':
                        currentView = 'gameDetail';
                        break;

                    case 'gameDetail':
                    default:
                        currentView = 'systemList';
                        break;
                }

                api.memory.set('currentView', currentView);
            }
        }
    }
}
