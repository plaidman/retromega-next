import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Rectangle {
    anchors {
        fill: parent;
    }

    Header.Component {
        id: header;
    }

    Footer.Component {
        id: footer;

        buttons: [
            { title: 'Select', key: 'A', square: false },
            { title: 'Menu', key: 'B', square: false },
        ];
    }

    Rectangle {
        anchors {
            top: header.bottom;
            bottom: footer.top;
            left: parent.left;
            right: parent.right;
        }

        Text {
            anchors.centerIn: parent;

            text: 'system list';
            color: '#000000';
        }
    }
}
