pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    property bool darkMode: true

    function toggleDarkMode() {
        darkMode = !darkMode;
    }

    // Canvas & backgrounds
    readonly property color bgCanvas:        darkMode ? "#09090b" : "#ffffff"
    readonly property color bgLoginCanvas:   "#050505"
    readonly property color bgSurface:       darkMode ? "#121215" : "#f5f5f7"

    // Borders & dividers
    readonly property color borderOuter:     darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.05) : Qt.rgba(0, 0, 0, 0.05)
    readonly property color borderInput:     darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.10) : Qt.rgba(0, 0, 0, 0.10)
    readonly property color borderButton:    darkMode ? Qt.rgba(0.96, 0.96, 0.96, 0.10) : Qt.rgba(0, 0, 0, 0.10)
    readonly property color borderFocus:     "#60cdea"
    readonly property color borderInverse:   "#09090b"

    // Typography & icons
    readonly property color textPrimary:     darkMode ? "#fafafa" : "#000000"
    readonly property color textPlaceholder: darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.60) : Qt.rgba(0, 0, 0, 0.60)
    readonly property color textMuted:       darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.40) : Qt.rgba(0, 0, 0, 0.40)
    readonly property color iconSubtle:      darkMode ? "#a1a1aa" : "#7f7f88"

    // Actions & brand
    readonly property color actionPrimaryBg: darkMode ? "#f4f4f5" : "#171717"
    readonly property color actionPrimaryFg: darkMode ? "#09090b" : "#ffffff"
    readonly property color accentBlue:      "#60cdea"
    readonly property color accentBlueSoft:  Qt.rgba(96 / 255, 205 / 255, 234 / 255, 0.25)

    // Status colors
    readonly property color statusSuccess:   darkMode ? "#4ac26b" : "#2da24e"
    readonly property color statusWarning:   "#e5c07b"
    readonly property color statusError:     darkMode ? "#ed8d9f" : "#cf6679"

    // Fonts
    readonly property string fontSans:       "Inter"
    readonly property string fontDisplay:    "Gued"
}

