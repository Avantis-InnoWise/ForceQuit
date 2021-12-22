//
//  MainScreenEntity.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

struct App: Equatable {
    var name: String
    var icon: NSImage
}

struct AppsListItem {
    let app: App
    var isSelected: Bool = false

    mutating func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }

    mutating func toggleSelection() {
        self.isSelected.toggle()
    }
}
