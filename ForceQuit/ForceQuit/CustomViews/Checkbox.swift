//
//  Checkbox.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

final class Checkbox: GradientButton {
    private enum Constants {
        static let checkImage = NSImage(named: "checkbox")
    }

    override func draw(_ dirtyRect: NSRect) {
        self.image = self.state == NSControl.StateValue.on ? Constants.checkImage : nil
        super.draw(dirtyRect)
    }
}
