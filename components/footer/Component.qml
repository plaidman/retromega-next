import QtQuick 2.12

Rectangle {
    height: 55;
    color: '#f3f3f3';

    anchors {
        left: parent.left;
        right: parent.right;
        bottom: parent.bottom;
    }

    Rectangle {
        height: 1;
        color: '#20000000';

        anchors {
            top: parent.top;
            left: parent.left;
            leftMargin: 22;
            right: parent.right;
            rightMargin: 22;
        }
    }

    ButtonLegend {
        id: buttonLegendA;

        title: 'Select';
        key: 'A';
        width: 65;

        anchors {
            left: parent.left;
            leftMargin: 32;
        }
    }

    ButtonLegend {
        title: 'Menu';
        key: 'B';

        anchors {
            left: buttonLegendA.right;
            leftMargin: 15;
        }
    }
}
