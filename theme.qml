import QtQuick 2.15

import 'components/systemList' as SystemList
import 'components/gameList' as GameList
import 'components/resources' as Resources

// todo list:
//   [o] system list
//     [x] controller support
//     [x] break up systemscroll.qml
//     [x] # of total in footer
//     [ ] touch support
//     [ ] better system name font spacing
//     [ ] rename all 'system' to collection
//   [o] game list
//     [x] rounded boxart
//     [x] # of total in footer
//     [x] system title in header
//     [o] controller support
//     [ ] verify things work when picking multi disk game, but cancelling.
//     [ ] touch support
//     [ ] DropShadow for boxart
//   [x] footer
//     [x] buttons
//     [x] # of total label
//   [x] header
//     [x] real time battery
//     [x] real time clock
//     [x] tap to switch 24 hour
//     [x] system title with color
//   [ ] system colors
//     [ ] make sure they are dark enough
//     [ ] remove duplicates
//   [ ] navigation sounds
//   [ ] bg music
//     [ ] button to start/stop
//   [ ] random select
//   [ ] new collections
//     [ ] ps2
//     [ ] wii
//     [ ] all
//     [ ] favorites
//     [ ] recents
//      https://www.vhv.rs/viewpic/ThTTbhi_wii-controller-hd-png-download/
//      https://www.vhv.rs/viewpic/ThTbhoR_wii-png-download-wii-mario-kart-controller-png/
//      https://www.vhv.rs/viewpic/iibbTRi_transparent-wii-controller-png-wii-classic-controller-pro/
//   [ ] update readme

//   [ ] all/favorites/recents/apps collections
//   [ ] zoomed out system view
//   [ ] game list
//     [ ] scrolling text instead of elipses
//     [ ] more thematic experience for multi-disk games
//   [ ] game detail view
//   [ ] alphabetic index
//   [ ] filter/sort modal
//   [ ] touch
//   [ ] dark mode
//   [ ] filterable android apps

FocusScope {
    property string currentView: 'systemList';
    property int currentCollectionIndex: 0;
    property var currentCollection;
    property int currentGameIndex: 0;
    property var currentGame;

    Component.onCompleted: {
        currentView = api.memory.get('currentView') ?? 'systemList';

        currentCollectionIndex = api.memory.get('currentCollectionIndex') ?? 0;
        currentCollection = api.collections.get(currentCollectionIndex);

        currentGameIndex = api.memory.get('currentGameIndex') ?? 0;
        currentGame = currentCollection.games.get(currentGameIndex);
    }

    Component.onDestruction: {
        api.memory.set('currentView', currentView);
        api.memory.set('currentCollectionIndex', currentCollectionIndex);
        api.memory.set('currentGameIndex', currentGameIndex);
    }

    Resources.SystemData { id: systemData; }
    function systemColor(shortName) {
        return systemData.systemColors[shortName] ?? systemData.systemColors['default'];
    }
    function systemCompany(shortName) {
        return systemData.systemCompanies[shortName] ?? '';
    }

    Rectangle {
        /* x: 200; */
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
