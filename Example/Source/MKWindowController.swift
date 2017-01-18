//
//  MKWindowController.swift
//  macOS Example
//
//  Created by Rob Hendriks on 18/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

class MKWindowController: NSWindowController {
    
    override func windowDidLoad() {
        window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
    }
}
