//
//  GradientButton.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

class GradientButton: BorderedRoundedButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer?.backgroundColor = NSColor.white.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        self.drawGradient(in: dirtyRect)
        super.draw(dirtyRect)
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.masksToBounds = true
    }
}
