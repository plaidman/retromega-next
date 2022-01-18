import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Rectangle {
    anchors {
        fill: parent;
    }

    SystemScroll {
        anchors {
            top: parent.top;
            bottom: footer.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: footer;

        buttons: [
            { title: 'Select', key: 'A', square: false },
            { title: 'Menu', key: 'B', square: false },
        ];
    }

    Header.Component {
        id: header;
        showDivider: false;
    }
}
