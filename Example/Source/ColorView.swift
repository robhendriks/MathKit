//
//  ColorView.swift
//  macOS Example
//
//  Created by Rob Hendriks on 19/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

@IBDesignable
class ColorView: NSView {
    
    @IBInspectable var color: NSColor = NSColor.black {
        didSet {
            layer?.backgroundColor = color.cgColor
        }
    }
    
    override func awakeFromNib() {
        self.wantsLayer = true
    }
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        layer?.backgroundColor = color.cgColor
    }
    
}
