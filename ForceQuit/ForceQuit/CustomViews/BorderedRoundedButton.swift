//
//  BorderedRoundedButton.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

class BorderedRoundedButton: NSButton {
    private enum Constant {
        static let titleColor = NSColor(named: "offButtonTitle")
        static let borderColor = NSColor(named: "buttonBorder")
        static let backgroundColor = NSColor(named: "roundedButtonBackground")
        static let backgroundBlueColor = NSColor(named: "roundedButtonColoredBackground")
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 5
        static let semiAlphaComponent: CGFloat = 0.5
        static let gradientInitialAlpha: CGFloat = 0.7
    }

    var isColored = false {
        didSet {
            self.draw(self.bounds)
        }
    }

    private var backgroundColor: NSColor? {
        self.isColored ? Constant.backgroundBlueColor : Constant.backgroundColor
    }

    override func draw(_ dirtyRect: NSRect) {
        if self.isColored {
            drawGradient(
                in: dirtyRect,
                initialColor: self.backgroundColor?
                    .withAlphaComponent(Constant.gradientInitialAlpha) ?? .clear,
                finalColor: self.backgroundColor ?? .clear
            )
        }

        super.draw(dirtyRect)

        if !self.isColored {
            self.layer?.backgroundColor = self.isHighlighted
            ? self.backgroundColor?.withAlphaComponent(Constant.semiAlphaComponent).cgColor
            : self.backgroundColor?.cgColor
        }

        self.layer?.borderColor = self.isColored
        ? Constant.backgroundBlueColor?.cgColor
        : Constant.borderColor?.cgColor

        self.attributedTitle = NSAttributedString(
            string: self.attributedTitle.string,
            attributes: [
                NSAttributedString.Key.foregroundColor : self.isColored
                ? NSColor.white
                : Constant.titleColor ?? NSColor.clear
            ]
        )
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.wantsLayer = true
        self.layer?.borderColor = Constant.borderColor?.cgColor
        self.layer?.borderWidth = Constant.borderWidth
        self.layer?.cornerRadius = Constant.cornerRadius
        self.layer?.backgroundColor = Constant.backgroundColor?.cgColor
        self.layer?.masksToBounds = true

        self.attributedTitle = NSAttributedString(
            string: self.attributedTitle.string,
            attributes: [NSAttributedString.Key.foregroundColor : Constant.titleColor ?? NSColor.clear]
        )
    }
}
