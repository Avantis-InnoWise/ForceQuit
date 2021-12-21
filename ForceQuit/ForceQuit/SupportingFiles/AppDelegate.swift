//
//  AppDelegate.swift
//  ForceQuit
//
//  Created by mac on 9.12.21..
//

import Cocoa
import Popover

class MyPopoverConfiguration: DefaultConfiguration {
    override var backgroundColor: NSColor {
        return NSColor.darkGray
    }

    override var borderColor: NSColor? {
        return NSColor.clear
    }
}

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

        let statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "xmark.circle", accessibilityDescription: "ForceQuit")
        }

        let popoverVC = PopoverViewController.loadFromNib()
        self.popover = Popover(with: MyPopoverConfiguration(), menuItems: [])
        self.popover.prepare(with: statusBarItem.button?.image ?? NSImage(), contentViewController: popoverVC)

        self.rootRouter = RootRouter()
        self.window.title = L10n.appTitle.localize()
        self.window?.contentViewController = rootRouter?.rootViewController
        self.window?.makeKeyAndOrderFront(nil)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
