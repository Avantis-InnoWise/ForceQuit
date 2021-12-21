//
//  NSButton+Extension.swift
//  ForceQuit
//
//  Created by mac on 21.12.21.
//

import Cocoa

extension NSButton {
    func makeButton(with color: NSColor, radius: CGFloat) {
        self.bezelStyle = .rounded
        self.wantsLayer = true
        self.isBordered = false
        self.layer?.backgroundColor = color.cgColor
        self.layer?.masksToBounds = true
        self.layer?.cornerRadius = radius
    }
}
