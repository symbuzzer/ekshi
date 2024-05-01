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

    header: Toolbar {
      id: header
      title: i18n.tr('ekshi')

      // Add navigation buttons
      LeftButton {
        iconName: "back" // Assuming you have an icon for back navigation
        onClicked: webview.back()
        enabled: webview.canGoBack()
      }

      RightButton {
        iconName: "next" // Assuming you have an icon for forward navigation
        onClicked: webview.forward()
        enabled: webview.canGoForward()
      }

      // Add a refresh button
      RightButton {
        iconName: "reload" // Assuming you have an icon for refresh
        onClicked: webview.reload()
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
      // ... other profile options
    }

    ProgressBar {
      id: loadingIndicator
      anchors {
        top: parent.top
        left: parent.left
        right: parent.right
      }
      value: webview.loadProgress / 100
      visible: webview.loadProgress === 100 ? false : true
    }

    Rectangle {
      id: webViewPlaceholder
      anchors {
        top: loadingIndicator.bottom
        left: parent.left
        right: parent.right
        bottom: parent.bottom
      }
      z: 1
      color: Suru.backgroundColor
      visible: webview.loadProgress === 100 ? false : true

      BusyIndicator {
        id: busy
        anchors.centerIn: parent
      }
    }
  }
}
