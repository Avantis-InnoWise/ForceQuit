//
//  Router.swift
//  ForceQuit
//
//  Created by mac on 9.12.21.
//

import AppKit

public protocol Router {
    var controlledViewController: NSViewController? { get }
}

public final class RootRouter: Router {
    public var controlledViewController: NSViewController? {
        return rootViewController
    }

    public var rootViewController: NSViewController?

    public init() {
        self.rootViewController = openMainScreen()
    }
}

extension RootRouter {
    func openMainScreen() -> NSViewController {
        return NSViewController() // MainScreenController.loadFromNib()
    }
}
