//
//  AppDelegate.swift
//  ForceQuit
//
//  Created by mac on 9.12.21..
//

import Cocoa
import Popover

@main
class AppDelegate: NSObject,
                   NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    private var rootRouter: RootRouter?
    private var popover: Popover!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window = NSWindow(contentRect: NSScreen.main?.frame ?? NSRect(),
                               styleMask: [.miniaturizable, .closable, .resizable, .titled],
                               backing: .buffered,
                               defer: false)

        let popoverController = PopoverViewController.loadFromNib()
        self.popover = Popover(with: MyPopoverConfiguration(), menuItems: [])
        self.popover.prepare(with: NSImage(named: "close.circle") ?? NSImage(),
                             contentViewController: popoverController)

        self.rootRouter = RootRouter()
        self.window.title = L10n.appTitle.localize()
        self.window.appearance = NSAppearance(named: .aqua)
        self.window?.contentViewController = rootRouter?.rootViewController
        self.window?.makeKeyAndOrderFront(nil)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApp.setActivationPolicy(.accessory)
        return true
    }
}
