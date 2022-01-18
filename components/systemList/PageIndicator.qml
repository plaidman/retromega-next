import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    property int currentIndex: 0;
    property int pageCount: 1;

    width: pageCount * (4 + 10)

    Row {
        spacing: 10;

        Repeater {
            model: pageCount;

            Rectangle {
                width: 4;
                height: 4;
                radius: 2;

                color: currentIndex === index ? 'white' : '#20ffffff';
            }
        }
    }
}
