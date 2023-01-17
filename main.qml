import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.0
import QtMultimedia 5.12

Window{
    visible: true
    width: 800
    height: 600
    title: qsTr("Player")
    property string sourcevideo

    Item{
        Video
        {
            id: video
            width : 800
            height : 600
            source: sourcevideo
        }
        Seeker {
            id:seeker
            anchors.bottom: video.bottom
            maximum:  video.duration
            value:    video.position
            minimum: 0
            onClicked: video.seek(value)
            }
        Row{
            Image{
                source: "images/folder.svg"
                MouseArea{
                    anchors.fill: parent
                    FileDialog {
                            id: fileDialog
                            title: qsTr("Select file")
                            onRejected: {
                                console.log("Canceled")
                            }
                            onAccepted: {
                                console.log("File selected: " + fileUrl)
                                sourcevideo = fileUrl
                                video.play()
                            }
                        }
                    onClicked: {
                        fileDialog.open()
                    }
                }
            }
            Image{
                source: "images/play.svg"
                MouseArea{
                    anchors.fill: parent
                    focus: true
                    Keys.onLeftPressed: video.seek(video.position - 10000)
                    Keys.onRightPressed: video.seek(video.position + 10000)
                    Keys.onSpacePressed: video.play()
                    onClicked: {video.play()}
                }
            }
            Image{
                source: "images/pause.svg"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {video.pause()}
                }
            }
        }

}
}
