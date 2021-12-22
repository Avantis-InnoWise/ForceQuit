//
//  MainScreenController.swift
//  ForceQuit
//
//  Created by mac on 9.12.21.
//

import Cocoa

final class MainScreenController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func terminateAllApps() {
        let openApps = NSWorkspace.shared.runningApplications
        for app in openApps where app.activationPolicy == .regular {
            app.forceTerminate()
        }
    }

    // can get icons from NSRunningAplication, title - the same
    @objc private func ternimateApp() {
        NSApplication.shared.terminate(AnyObject.self)
    }
}
