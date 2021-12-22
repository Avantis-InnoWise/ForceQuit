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

    func drawGradient(
        in rect: NSRect,
        with gradientAngle: CGFloat = 270.0,
        initialColor: NSColor = NSColor(named: "gradientButtonTop")!,
        finalColor: NSColor = NSColor(named: "gradientButtonBottom")!
    ) {
        let gradientAngle = gradientAngle
        let gradient = NSGradient(colors: [
            isHighlighted
            ? finalColor.withAlphaComponent(0.5)
            : finalColor,
            initialColor
        ])
        gradient?.draw(in: rect, angle: gradientAngle)
    }
}
