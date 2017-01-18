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
    
    public static let bgColor = NSColor(red: 100.0 / 255.0, green: 149.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    
    var cube: MKGeometry
    var camera: MKCamera
    
    required init?(coder: NSCoder) {
        cube = MKGeometry.fromFile(Bundle.main.path(forResource: "Cube", ofType: "txt")!)!
        camera = MKCamera(Vector(0, 0, 800), Vector(0, 0, 0))
    
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        MKView.bgColor.setFill()
        NSRectFill(dirtyRect)
        
        let width = Double(dirtyRect.size.width)
        let _ = Double(dirtyRect.size.height)
        
        var matrix = cube.matrix * camera.matrix
        matrix = matrix * camera.projection
        
        Swift.print(matrix)
        
        for i in 0..<matrix.rows {
            matrix[i, 0] = (width / 2) + ((matrix[i, 0] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 1] = (width / 2) + ((matrix[i, 1] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 2] = -matrix[i, 2]
        }
        
        for face in cube.faces {
            var points = [Vector]()
            
            for i in face {
                guard matrix[i, 3] >= 0 else {
                    continue
                }
                points.append(Vector(matrix[i, 0], matrix[i, 1], matrix[i, 2]))
            }
            
            drawFace(points)
        }
    }
    
    func drawFace(_ points: [Vector]) {
        guard points.count == 4 else {
            return
        }
        
        let path = NSBezierPath()
        
        for i in 0..<points.count {
            let point = points[i]
            
            if i == 0 {
                path.move(to: NSPoint(x: point.x, y: point.y))
            } else {
                path.line(to: NSPoint(x: point.x, y: point.y))
            }
        }
        
        path.close()
        path.stroke()
    }
    
    func keyDown(keyCode: UInt16) {
        switch keyCode {
        case 13: // W
            cube.translate(0, 10, 0)
            break
        case 1: // S
            cube.translate(0, -10, 0)
            break
        case 0: // A
            cube.translate(-10, 0, 0)
            break
        case 2: // D
            cube.translate(10, 0, 0)
            break
        case 12: // Q
            cube.translate(0, 0, 10)
            break
        case 14: // E
            cube.translate(0, 0, -10)
            break
        default:
            break
        }
        
        setNeedsDisplay(bounds)
    }
    
}
