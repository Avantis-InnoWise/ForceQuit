//
//  UIEdgeInsets+Extension.swift
//  ForceQuit
//
//  Created by mac on 21.12.21.
//

import Cocoa

extension NSEdgeInsets {
    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }

    init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}
