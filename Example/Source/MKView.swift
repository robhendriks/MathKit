//
//  MKView.swift
//  macOS Example
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

@IBDesignable
class MKView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current()?.cgContext
        
        context?.setFillColor(NSColor.red.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
}
