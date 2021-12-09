//
//  AppDelegate.swift
//  ForceQuit
//
//  Created by mac on 9.12.21..
//

import Cocoa

@main
class AppDelegate: NSObject,
                   NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    private var rootRouter: RootRouter?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window = NSWindow(contentRect: NSScreen.main?.frame ?? NSRect(),
                               styleMask: [.miniaturizable, .closable, .resizable, .titled],
                               backing: .buffered,
                               defer: false)
        self.rootRouter = RootRouter()
        window.title = L10n.appTitle.localize()
        window?.contentViewController = rootRouter?.rootViewController
        self.window?.makeKeyAndOrderFront(nil)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}


//func applicationDidFinishLaunching(_ aNotification: Notification) {
//    let contentView = ContentView()
//
//    let popover = NSPopover()
//    popover.contentSize = NSSize(width: contentView.width, height: contentView.height)
//    popover.behavior = .transient
//    popover.contentViewController = NSHostingController(rootView: contentView)
//    self.popover = popover
//
//    statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
//
//    if let button = statusBarItem.button {
//        button.image = NSImage(systemSymbolName: "xmark.circle", accessibilityDescription: "Nuke")
//        button.action = #selector(togglePopover(_:))
//    }
//}
//
//@objc func togglePopover(_ sender: AnyObject?) {
//    if let button = statusBarItem.button {
//        if popover.isShown {
//            popover.performClose(sender)
//        } else {
//            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
//        }
//    }
//}
