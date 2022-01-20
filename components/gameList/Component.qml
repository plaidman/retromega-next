import QtQuick 2.15

Item {
    anchors {
        fill: parent;
    }

    Text {
        anchors.centerIn: parent;

        text: 'game list ' + api.collections.get(currentCollection).shortName;
        color: '#000000';
    }

    Keys.onPressed: {
        if (api.keys.isBack(event)) {
            event.accepted = true;

            currentView = 'systemList';
        }
    }
}
