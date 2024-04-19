/*
 * Copyright (C) 2023  Rúben Carneiro
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * ekshi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Suru 2.2
import Morph.Web 0.1
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtWebEngine 1.7


MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'ekshi.symbuzzer'
    theme.name: "Lomiri.Components.Themes.SuruDark"
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('ekshi - eksisozluk.com gayriresmi istemci')
        }

    WebEngineView {
        id: webview
        anchors.fill: parent
        width: units.gu(45)
        height: units.gu(75)
        url: "https://eksisozluk.com/basliklar/gundem/"
        zoomFactor: 3.0 //scales the webpage on the device, range allowed from 0.25 to 5.0; the default factor is 1.0
        profile: webViewProfile
    }

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies;
        storageName: "Storage"
        httpCacheType: WebEngineProfile.DiskHttpCache; //cache qml content to file
        httpUserAgent: "Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Mobile Safari/537.36";
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
        //aquire the webviews loading progress for the indicators value
        value: webview.loadProgress/100
        //hide loadingIndicator when page has been loaded successfully
        visible: webview.loadProgress === 100 ? false : true
    }

    Rectangle {
        //show placeholder while the page is loading to avoid ugly flickering of webview
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
