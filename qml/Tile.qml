import QtQuick 2.0
import "widget"

Item {
    id: frame

    signal clicked

    property string tileSet: "std"
    property int tileWidth
    property int tileHeight: tileWidth * 1.35
    property string tileStr
    property color backColor: "#DD9900"
    property bool clickable: false
    property bool dark: false
    property bool lay: false

    // make item square when lay for ease of anchoring
    width: lay ? tileHeight : tileWidth
    height: tileHeight
    visible: false

    Rectangle {
        border.width: 2
        border.color: "#99333333"
        width: tileWidth
        height: tileWidth * 1.35
        color: frame.tileStr === "back" ? backColor
                                        : frame.dark ? "#888899" : "#E8E9DB"

        Image {
            id: image
            anchors.margins: parent.border.width
            anchors.fill: parent
            fillMode: Image.Stretch
            source: "/pic/tile/" + tileSet + "/Z.png"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            propagateComposedEvents: !frame.clickable
            onClicked: {
                if (frame.clickable)
                    frame.clicked();
            }
        }

        transform: [
            Rotation { angle: frame.lay ? -90 : 0 },
            Translate { y: frame.lay ? tileHeight : 0 }
        ]
    }

    onTileStrChanged: {
        if (tileStr === "hide") {
            visible = false;
        } else if (tileStr === "back") {
            visible = true;
            image.source = "";
        } else {
            visible = true;
            if (!tileStr)
                throw "Tile.qml: falsy tileStr";
            image.source = "/pic/tile/" + tileSet + "/" + tileStr + ".png";
        }
    }

    onTileSetChanged: {
        if (tileStr)
            tileStrChanged();
    }
}
