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
    
    static let bgColor = NSColor(red: 100.0 / 255.0, green: 149.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    
    static let cubeStroke = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let cubeFill = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
    
    var cube: MKGeometry
    var camera: MKCamera
    
    required init?(coder: NSCoder) {
        cube = MKGeometry.fromFile(Bundle.main.path(forResource: "Plane", ofType: "txt")!)!
        cube.translate(-50, -50, -100)
        
        camera = MKCamera(Vector(0, 0, 10), Vector(0, 0, 0))
    
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        MKView.bgColor.setFill()
        NSRectFill(dirtyRect)
        
        let width = Double(dirtyRect.size.width)
        let _ = Double(dirtyRect.size.height)
        
        var matrix = cube.matrix * camera.matrix * camera.projection
        
        for i in 0..<matrix.rows {
            matrix[i, 0] = (width / 2) + ((matrix[i, 0] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 1] = (width / 2) + ((matrix[i, 1] + 1) / matrix[i, 3]) * width * 0.5
            matrix[i, 2] = -matrix[i, 2]
        }
        
        outer: for face in cube.faces {
            var points = [Vector]()
            
            for i in face {
//                matrix[i, 0] >= 0 && matrix[i, 1] >= 0 && matrix[i, 2] >= 0 && 
                guard matrix[i, 3] >= 0 else {
                    continue outer
                }
                points.append(Vector(matrix[i, 0], matrix[i, 1], matrix[i, 2]))
            }
            
            drawFace(points)
        }
    }
    
    func drawFace(_ points: [Vector]) {
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
        MKView.cubeFill.setFill()
        
        path.close()
        path.stroke()
        path.fill()
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
        case 18: // OEM1
            camera.fieldOfView = 60.0
            break
        case 19: // OEM2
            camera.fieldOfView = 90.0
            break
        case 20: // OEM3
            camera.fieldOfView = 120.0
            break
        default:
            Swift.print(keyCode)
            return
        }
        
        setNeedsDisplay(bounds)
    }
    
}
