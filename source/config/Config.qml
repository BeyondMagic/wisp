pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property string currentUser: Quickshell.env("USER") || "terra"
    readonly property string displayName: "BeyondMagic"
    readonly property string avatarPath:  "assets/avatar.png"

    readonly property var quoteDatabases: [
        { label: "General",  path: "/home/terra/storage/desktop/quotes/general.json" },
        { label: "Personal", path: "/home/terra/storage/desktop/quotes/personal.json" },
        { label: "TV",       path: "/home/terra/storage/desktop/quotes/tv.json" },
        { label: "Books",    path: "/home/terra/storage/desktop/quotes/books.json" },
        { label: "Music",    path: "/home/terra/storage/desktop/quotes/music.json" },
        { label: "Story",    path: "/home/terra/storage/desktop/quotes/story.json" }
    ]
}

