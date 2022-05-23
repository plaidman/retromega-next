import QtQuick 2.15
import QtGraphicalEffects 1.12

import '../footer' as Footer

Item {
    property var blurSource;
    property alias textInput: nameFilterTextInput;

    // background to lighten or darken the blur effect, since it's translucent
    Rectangle {
        color: theme.current.bgColor;
        anchors.fill: parent;
    }

    FastBlur {
        width: root.width;
        height: root.height;
        radius: 80;
        opacity: .4;
        source: blurSource;
        cached: true;
    }

    // todo: adjust for text scale
    // todo: adjust for dark mode
    Rectangle {
        radius: 10;
        height: parent.height * .4;
        width: parent.width * .7;
        color: theme.current.bgColor;
        border.color: theme.current.dividerColor;

        anchors {
            verticalCenter: parent.verticalCenter;
            horizontalCenter: parent.horizontalCenter;
        }

        Text {
            id: modalTitle;

            text: 'Name Filter';
            height: root.height * .115 * theme.fontScale;
            verticalAlignment: Text.AlignVCenter;
            // todo font color

            font {
                // todo theme size
                family: globalFonts.sans;
                pixelSize: parent.height * .11;
                letterSpacing: -0.3;
                bold: true;
            }

            anchors {
                top: parent.top;
                left: parent.left;
                leftMargin: 32;
            }
        }

        Rectangle {
            id: modalDividerTop;

            height: 1;
            // todo theme
            color: theme.current.dividerColor;

            anchors {
                top: modalTitle.bottom;
                left: parent.left;
                leftMargin: 22;
                right: parent.right;
                rightMargin: 22;
            }
        }

        Rectangle {
            id: textBox;

            // todo theme
            border.color: 'black';
            // todo theme
            color: 'yellow';

            /* width: parent.width - 44; */
            /* height: parent.height * .25; */

            anchors {
                top: modalDividerTop.bottom;
                topMargin: 22;
                left: parent.left;
                leftMargin: 22;
                right: parent.right;
                rightMargin: 22;
                bottom: nameFilterModalFooter.top;
                bottomMargin: 22;
            }

            Text {
                text: '(no filter set)';
                verticalAlignment: Text.AlignVCenter;
                color: 'grey';
                visible: nameFilterTextInput.text === '';

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    family: globalFonts.sans;
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }

            TextInput {
                id: nameFilterTextInput;

                text: nameFilter;
                verticalAlignment: Text.AlignVCenter;

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    family: globalFonts.sans;
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }
        }

        Footer.Component {
            id: nameFilterModalFooter;

            total: 0;
            radius: 11;

            anchors {
                bottomMargin: 1;
                leftMargin: 1;
                rightMargin: 1;
            }

            buttons: [
                { title: 'Filter', key: 'A', square: false, sigValue: 'accept' },
                { title: 'Cancel', key: 'B', square: false, sigValue: 'cancel' },
                { title: 'Clear', key: 'X', square: false, sigValue: 'clear' },
            ];

            onFooterButtonClicked: {
                if (sigValue === 'accept') onAcceptPressed();
                if (sigValue === 'cancel') onCancelPressed();
                if (sigValue === 'clear') onClearPressed();
            }
        }
    }
}
