//
//  MKView.swift
//  macOS Example
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa
import MathKit

@IBDesignable
class MKView: NSView {
    
    var matrix: Matrix
    
    required init?(coder: NSCoder) {
        matrix = Matrix([
            [0, 0, 1],
            [10, 0, 1],
            [10, 10, 1],
            [5, 15, 1],
            [0, 10, 1]
        ])
        
        matrix = matrix.scale(10, 10).translate(50, 50)
        
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let path = NSBezierPath()
        var prev: NSPoint?
        var first: NSPoint?
        
        for i in 0..<matrix.rows {
            let point = NSPoint(x: matrix[i,0] ,y: matrix[i,1])
            path.move(to: point)
            
            if let _prev = prev {
                path.line(to: _prev)
            } else {
                first = point
            }
            
            prev = point
        }
        
        path.move(to: first!)
        path.line(to: prev!)
        
        NSColor.red.setStroke()
        NSColor.green.setFill()
        path.stroke()
        
        
    }
    
}
