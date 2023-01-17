import QtQuick 2.0

Item {
    id: root
    signal clicked(double value);
    property double maximum: 10
    property double value:    0
    property double minimum:  0
    width: 800;  height: 20
    opacity: enabled  &&  !mouseArea.pressed? 1: 0.3

    Repeater {
        model: 2

        delegate: Rectangle {
            x:     !index?               0: pill.x + pill.width - radius
            width: !index? pill.x + radius: root.width - x;  height: 0.1 * root.height
            radius: 0.5 * height
            color: 'grey'
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: pill

        x: (value - minimum) / (maximum - minimum) * (root.width - pill.width) // pixels from value
        width: parent.height;  height: width
        border.width: 0.05 * root.height
        radius: 0.5 * height
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag {
            target:   pill
            axis:     Drag.XAxis
            maximumX: root.width - pill.width
            minimumX: 0
        }
        onPositionChanged:  if(drag.active) setPixels(pill.x + 0.5 * pill.width) // drag pill
        onClicked:                          setPixels(mouse.x) // tap tray
    }

    function setPixels(pixels) {
        var value = (maximum - minimum) / (root.width - pill.width) * (pixels - pill.width / 2) + minimum
        clicked(Math.min(Math.max(minimum, value), maximum))
    }
}
