//
//  PopoverViewController.swift
//  ForceQuit
//
//  Created by mac on 21.12.21.
//

import Cocoa
import SnapKit

final class PopoverViewController: NSViewController {
    enum Constants {
        static let terminateInsets: NSEdgeInsets = NSEdgeInsets(all: 5)
        static let cornerRadius: CGFloat = 5
        static let blackColor: NSColor = NSColor.black
    }

    @IBOutlet private weak var boxView: NSBox!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    }

    private func configureView() {
        self.boxView.fillColor = .white
        self.boxView.cornerRadius = 5
        self.boxView.borderColor = .clear

        let terminateAllButton = NSButton()
        terminateAllButton.makeButton(with: Constants.blackColor, radius: Constants.cornerRadius)
        terminateAllButton.setAccessibilityIdentifier("terminate_button")
        terminateAllButton.attributedTitle = NSAttributedString(string: L10n.terminateAll.localize(),
                                                                attributes: [NSAttributedString.Key.foregroundColor : NSColor.white])
        terminateAllButton.action = #selector(ternimateAllApplications)

        let openAppButton = NSButton()
        openAppButton.makeButton(with: Constants.blackColor, radius: Constants.cornerRadius)
        openAppButton.setAccessibilityIdentifier("open_button")
        openAppButton.attributedTitle = NSAttributedString(string: L10n.openApp.localize(),
                                                           attributes: [NSAttributedString.Key.foregroundColor : NSColor.white])
        openAppButton.action = #selector(openApplication)

        self.setupConstraints(with: terminateAllButton, openAppButton)
    }

    private func setupConstraints(with buttons: NSButton...) {
        buttons.forEach { button in
            self.boxView.addSubview(button)
            switch button.accessibilityIdentifier() {
            case "terminate_button":
                button.snp.makeConstraints {
                    $0.height.equalTo(40)
                    $0.top.equalTo(self.boxView.snp.top).inset(Constants.terminateInsets.top)
                    $0.left.equalTo(self.boxView.snp.left).inset(Constants.terminateInsets.left)
                    $0.right.equalTo(self.boxView.snp.right).inset(Constants.terminateInsets.right)
                }
            case "open_button":
                button.snp.makeConstraints {
                    $0.height.equalTo(40)
                    $0.left.equalTo(self.boxView.snp.left).inset(Constants.terminateInsets.left)
                    $0.right.equalTo(self.boxView.snp.right).inset(Constants.terminateInsets.right)
                    $0.bottom.equalTo(self.boxView.snp.bottom).inset(Constants.terminateInsets.bottom)
                }
            default:
                break
            }
        }
    }

    // can get icons from NSRunningAplication, title - the same
    @objc private func ternimateAllApplications() {
        let openApps = NSWorkspace.shared.runningApplications
        for app in openApps where app.activationPolicy == .regular {
            app.forceTerminate()
        }
    }

    @objc private func openApplication() {
        debugPrint("open pressed")
    }
}
