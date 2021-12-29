//
//  SectionButton.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

final class SectionButton: NSButton {
    private enum Constant {
        static let onButtonTitleColor = NSColor(named: "onButtonTitle") ?? .black
        static let offButtonTitleColor = NSColor(named: "offButtonTitle") ?? .gray
        static let selectedButtonColor = NSColor(named: "selectedButton")
        static let unselectedButtonColor = NSColor(named: "unselectedButton")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.setupUI()
    }

    private func setupUI() {
        self.layer?.backgroundColor = self.state == .on
        ? Constant.selectedButtonColor?.cgColor
        : Constant.unselectedButtonColor?.cgColor

        self.attributedTitle = NSAttributedString(
            string: self.attributedTitle.string,
            attributes: [
                NSAttributedString.Key.foregroundColor :
                    self.state == .on ? Constant.onButtonTitleColor : Constant.offButtonTitleColor
            ]
        )
    }
}
