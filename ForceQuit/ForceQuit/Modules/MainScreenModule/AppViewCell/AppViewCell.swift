//
//  AppViewCell.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
//

import Cocoa

final class AppViewCell: NSTableCellView {
    @IBOutlet private weak var checkbox: Checkbox!
    @IBOutlet private weak var appIconImageView: NSImageView!
    @IBOutlet private weak var appNameLabel: NSTextField!
    @IBOutlet private weak var cpuLabel: NSTextField!

    private var checkboxHandler: (() -> Void)?

    func configure(with item: AppsListItem, checkboxHandler: @escaping () -> Void) {
        self.checkbox.state = item.isSelected ? .on : .off
        self.appIconImageView.image = item.app.icon
        self.cpuLabel.stringValue = item.app.cpu
        self.appNameLabel.stringValue = item.app.name
        self.checkboxHandler = checkboxHandler
    }

    func updateCheckbox(state: Bool) {
        self.checkbox.state = state ? .on : .off
    }

    @IBAction private func checkboxWasTapped(_ sender: Checkbox) {
        self.checkboxHandler?()
    }
}
