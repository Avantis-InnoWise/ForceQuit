//
//  PopoverEntity.swift
//  ForceQuit
//
//  Created by mac on 22.12.21.
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
