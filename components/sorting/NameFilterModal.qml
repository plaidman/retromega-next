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

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                onCancelPressed();
            }
        }
    }

    FastBlur {
        width: root.width;
        height: root.height;
        radius: 80;
        opacity: .4;
        source: blurSource;
        cached: true;
    }

    Rectangle {
        radius: 10;
        height: parent.height * .4;
        width: parent.width * .7;
        color: theme.current.bgColor;
        border.color: theme.current.dividerColor;

        anchors {
            top: parent.top;
            topMargin: root.height * .06;
            horizontalCenter: parent.horizontalCenter;
        }

        Text {
            id: modalTitle;

            text: 'Name Filter';
            height: root.height * .115;
            verticalAlignment: Text.AlignVCenter;
            color: theme.current.defaultHeaderNameColor

            font {
                pixelSize: parent.height * .11;
                letterSpacing: -0.3;
                bold: true;
            }

            anchors {
                top: parent.top;
                left: parent.left;
                leftMargin: 27;
            }
        }

        Rectangle {
            id: modalDividerTop;

            height: 1;
            color: theme.current.dividerColor;

            anchors {
                top: modalTitle.bottom;
                left: parent.left;
                leftMargin: 23;
                right: parent.right;
                rightMargin: 23;
            }
        }

        Rectangle {
            id: textBox;

            border.color: theme.current.textInputBorderColor;
            color: theme.current.textInputBackgroundColor;

            anchors {
                top: modalDividerTop.bottom;
                topMargin: 20;
                left: parent.left;
                leftMargin: 27;
                right: parent.right;
                rightMargin: 27;
                bottom: nameFilterModalFooter.top;
                bottomMargin: 20;
            }

            Text {
                text: '(no filter)';
                verticalAlignment: Text.AlignVCenter;
                color: theme.current.textInputPlaceholderColor;
                visible: nameFilterTextInput.preeditText === '' && nameFilterTextInput.text === '';

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
                    pixelSize: parent.height * .6;
                    letterSpacing: -0.3;
                    bold: true;
                }
            }

            TextInput {
                id: nameFilterTextInput;

                text: nameFilter;
                verticalAlignment: Text.AlignVCenter;
                color: theme.current.defaultHeaderNameColor

                anchors {
                    fill: parent;
                    leftMargin: 10;
                }

                font {
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
                { title: 'Filter', key: theme.buttonGuide.accept, square: false, sigValue: 'accept' },
                { title: 'Cancel', key: theme.buttonGuide.cancel, square: false, sigValue: 'cancel' },
                { title: 'Clear', key: theme.buttonGuide.details, square: false, sigValue: 'clear' },
            ];

            onFooterButtonClicked: {
                if (sigValue === 'accept') onAcceptPressed();
                if (sigValue === 'cancel') onCancelPressed();
                if (sigValue === 'clear') onClearPressed();
            }
        }
    }
}
