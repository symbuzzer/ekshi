import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Suru 2.2
import Morph.Web 0.1
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtWebEngine 1.7
import Ubuntu.Components 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'ekshi.symbuzzer'

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('ekshi')
            tools: Row {
                spacing: units.gu(1)
                ToolButton {
                    text: "Back"
                    onClicked: webview.goBack()
                }
                ToolButton {
                    text: "Forward"
                    onClicked: webview.goForward()
                }
                ToolButton {
                    text: "Refresh"
                    onClicked: webview.reload()
                }
            }
        }

        WebEngineView {
            id: webview
            anchors.fill: parent
            width: units.gu(45)
            height: units.gu(75)
            url: "https://eksisozluk.com/"
            zoomFactor: 3.0
            profile: webViewProfile
        }

        WebEngineProfile {
            id: webViewProfile
            persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
            storageName: "Storage"
            httpCacheType: WebEngineProfile.DiskHttpCache
            httpUserAgent: "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Mobile Safari/537.36"
            property alias dataPath: webViewProfile.persistentStoragePath
            dataPath: dataLocation
            persistentStoragePath: "/home/phablet/.cache/ekshi.symbuzzer/QtWebEngine"
        }

        ProgressBar {
            id: loadingIndicator
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            value: webview.loadProgress / 100
            visible: webview.loadProgress !== 100
        }

        Rectangle {
            id: webViewPlaceholder
            anchors.fill: parent
            z: 1
            color: Suru.backgroundColor
            visible: webview.loadProgress !== 100

            BusyIndicator {
                id: busy
                anchors.centerIn: parent
            }
        }
    }
}
