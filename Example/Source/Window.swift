//
//  Window.swift
//  macOS Example
//
//  Created by Rob Hendriks on 18/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

class Window: NSWindow {
    
    override func keyDown(with event: NSEvent) {
//        super.keyDown(with: event)
        
        if let vc = contentViewController as? ViewController {
            vc.keyDown(keyCode: event.keyCode)
        }
    }
    
}
