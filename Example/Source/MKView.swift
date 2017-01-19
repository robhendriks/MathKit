//
//  MKView.swift
//  macOS Example
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa
import MathKit

class MKView: NSView {
    
    static let bgColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    static let cubeStroke = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let cubeFill = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
    
    var cube: MKGeometry!
    var camera: MKCamera
    
    var keys = [UInt16: Bool]()
    var move = Vector.zero
    var rotate = Vector.zero
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        camera = MKCamera(Vector(0, 0, 10), Vector(0, 0, 0))
        super.init(coder: coder)
        
        load("Cube")
        
        Timer.scheduledTimer(withTimeInterval: 1000.0 / 60.0 / 1000.0, repeats: true) { timer in
            self.update()
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
//        MKView.bgColor.setFill()
//        NSRectFill(dirtyRect)
        
        let width = Double(dirtyRect.size.width)
        let _ = Double(dirtyRect.size.height)
        
        var matrix = cube.matrix * camera.matrix * camera.projection
        
        for i in 0..<matrix.rows {
            matrix[i, 0] = (width / 2) + ((matrix[i, 0] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 1] = (width / 2) + ((matrix[i, 1] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 2] = -matrix[i, 2]
        }
        
        outer: for (i, face) in cube.faces.enumerated() {
            var points = [Vector]()
            
            for i in face {
//                matrix[i, 0] >= 0 && matrix[i, 1] >= 0 && matrix[i, 2] >= 0 && 
                guard matrix[i, 3] >= 0 else {
                    continue outer
                }
                points.append(Vector(matrix[i, 0], matrix[i, 1], matrix[i, 2]))
            }
            
            drawFace(points, cube.colors[i])
        }
    }
    
    public func load(_ name: String) {
        cube = MKGeometry.fromFile(Bundle.main.path(forResource: name, ofType: "txt")!)!
        
        let center = cube.matrix.center
        cube.translate(-center.x, -center.y, center.z)
        
        move = Vector.zero
        rotate = Vector.zero
        
        keys.removeAll(keepingCapacity: false)
        
        setNeedsDisplay(bounds)
    }
    
    func update() {
        if let _ = keys[2] {
            move.x = 2
        } else if let _ = keys[0] {
            move.x = -2
        } else {
            move.x = 0
        }
        
        if let _ = keys[13] {
            move.y = 2
        } else if let _ = keys[1] {
            move.y = -2
        } else {
            move.y = 0
        }
        
        if let _ = keys[12] {
            move.z = 2
        } else if let _ = keys[14] {
            move.z = -2
        } else {
            move.z = 0
        }
        
        if let _ = keys[123] {
            rotate.y = 1
        } else if let _ = keys[124] {
            rotate.y = -1
        } else {
            rotate.y = 0
        }
        
        if let _ = keys[126] {
            rotate.z = 1
        } else if let _ = keys[125] {
            rotate.z = -1
        } else {
            rotate.z = 0
        }
        
        if move.x != 0 || move.y != 0 || move.z != 0 {
            cube.translate(move)
            setNeedsDisplay(bounds)
        }
    }
    
    func drawFace(_ points: [Vector], _ color: NSColor?) {
        let path = NSBezierPath()
        
        for i in 0..<points.count {
            let point = points[i]
            
            if i == 0 {
                path.move(to: NSPoint(x: point.x, y: point.y))
            } else {
                path.line(to: NSPoint(x: point.x, y: point.y))
            }
        }
        
        MKView.cubeStroke.setStroke()
        
        if let color = color {
            color.setFill()
        } else {
            MKView.cubeFill.setFill()
        }
        
        path.close()
        path.stroke()
        path.fill()
    }
    
    override func keyDown(with event: NSEvent) {
        if let _ = keys[event.keyCode] {
            return
        }
        keys[event.keyCode] = true
        Swift.print("gained \(event.keyCode)")
    }
    
    override func keyUp(with event: NSEvent) {
        if let _ = keys[event.keyCode] {
            keys.removeValue(forKey: event.keyCode)
            Swift.print("lost \(event.keyCode)")
        }
    }
    
}
