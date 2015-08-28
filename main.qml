import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import com.ics.demo 1.0

ApplicationWindow {
    id: window
    title: qsTr("ATicTacToe")
    width: 540
    height: 840
    visible: true

    FontLoader { id: sfont; source: "qrc:/fonts/Schoolbell.ttf" }

    Flipable {
        id: flipable

        property bool flipped: false

        state: "menu"
        width: window.width
        height: window.height

        transform: Rotation {
            id: rot
            angle: 0
            origin.x: 0
            origin.y: flipable.height/2
            axis.x: 0; axis.y: -1; axis.z: 0
        }
        front: Image {
            id: menuForm
            source: "qrc:/images/bg.jpg"
            width: window.width
            height: window.height
            mirror: true

            Column {
                anchors.centerIn: parent
                ClickableText {
                    text: "Play"
                    textSize: 50
                    fontFamily: sfont.name
                    onClicked: {
                        flipable.state =  "play"
                        console.log("Stage changed to " + flipable.state)
                    }
                }
            }
        }

        back: MainForm {
            id: gameForm
            font: sfont.name
        }

        states: [
            State {
                name: "menu"
                PropertyChanges {
                    target: rot;
                    angle: 0;
                }
                PropertyChanges {
                    target: gameForm;
                    visible: false;
                }
                PropertyChanges {
                    target: menuForm;
                    enabled: true;
                }
                PropertyChanges {
                    target: flipable
                    x: 0
                }
                PropertyChanges {
                    target: bg
                    x: 0
                }
            },
            State {
                name: "play"
                PropertyChanges {
                    target: rot;
                    angle: 180;
                }
                PropertyChanges {
                    target: gameForm;
                    visible: true;
                }
                PropertyChanges {
                    target: menuForm;
                    enabled: false;
                }
                PropertyChanges {
                    target: flipable
                    x: width
                }
                PropertyChanges {
                    target: bg
                    x: width
                }
            }
        ]
        transitions: [
            Transition {
                from: "menu"; to: "play"
                SequentialAnimation {
                    NumberAnimation { target: rot; property: "angle"; duration: 1000 }
                    PropertyAnimation { target: gameForm; property: "visible"; }
                    ParallelAnimation {
                        NumberAnimation { target: flipable; property: "x"; duration: 500 }
                        NumberAnimation { target: bg; property: "x"; duration: 500 }
                    }
                    PropertyAnimation { target: gameForm.gameField; property: "visible"; }
                }
            },
            Transition {
                from: "play"; to: "menu"
                NumberAnimation { target: rot; property: "angle"; duration: 1000 }
            }
        ]
    }
    Image {
        id: bg

        source: "qrc:/images/bg.jpg"
        width: window.width
        height: window.height
        mirror: true
        z: -1
    }
}
