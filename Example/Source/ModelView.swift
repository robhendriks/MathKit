//
//  MKView.swift
//  macOS Example
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa
import MathKit

class ModelView: NSView {
    
    static let bgColor = NSColor(red: 100 / 255, green: 149 / 255, blue: 237 / 255, alpha: 1.0)
    static let cubeStroke = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let cubeFill = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
    
    var geometry: MKGeometry?
    var camera: MKCamera!
    var guide: Matrix?
    
    var keys = [UInt16: Bool]()
    
    var translate = Matrix.identity
    var rotate = Matrix.identity
    var scale = Matrix.identity
    
    var colorFaces: Bool = true {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        camera = MKCamera(Vector(0, 0, 100), Vector(0, 0, 0), bounds.size)
        
        Timer.scheduledTimer(withTimeInterval: 1000.0 / 60.0 / 1000.0, repeats: true) { timer in
            self.update()
        }
    }
    
    override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        
        camera.screenSize = bounds.size
        setNeedsDisplay(bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        drawGuide(dirtyRect)
        drawGeometry(dirtyRect)
    }
    
    func buildGuide() {
        guard let matrix = geometry?.matrix else {
            return
        }
        
        let product = matrix * scale * translate * rotate
        let center = product.center
        
        let x = center.x
        let y = center.y
        let z = center.z
        
        guide = Matrix([
            [x - 50, y, z, 0],
            [x + 50, y, z, 0],
            [x, y - 50, z, 0],
            [x, y + 50, z, 0],
            [x, y, z - 50, 0],
            [x, y, z + 50, 0],
        ])
    }
    
    func drawGuide(_ dirtyRect: NSRect) {
        guard let guide = guide else {
            return
        }
        
        let matrix = getMatrix(guide * scale * translate, dirtyRect.size)

        // Draw x-axis
        if matrix[0, 3] >= 0 && matrix[1, 3] >= 0 {
            let path = NSBezierPath()
            path.move(to: NSPoint(x: matrix[0, 0], y: matrix[0, 1]))
            path.line(to: NSPoint(x: matrix[1, 0], y: matrix[1, 1]))
            
            NSColor.red.setStroke()
            path.stroke()
        }
        
        // Draw y-axis
        if matrix[2, 3] >= 0 && matrix[3, 3] >= 0 {
            let path = NSBezierPath()
            path.move(to: NSPoint(x: matrix[2, 0], y: matrix[2, 1]))
            path.line(to: NSPoint(x: matrix[3, 0], y: matrix[3, 1]))
            
            NSColor.green.setStroke()
            path.stroke()
        }
        
        // Draw z-axis
        if matrix[4, 3] >= 0 && matrix[5, 3] >= 0 {
            let path = NSBezierPath()
            path.move(to: NSPoint(x: matrix[4, 0], y: matrix[4, 1]))
            path.line(to: NSPoint(x: matrix[5, 0], y: matrix[5, 1]))
            
            NSColor.blue.setStroke()
            path.stroke()
        }

    }
    
    func drawGeometry(_ dirtyRect: NSRect) {
        guard let geometry = geometry else {
            return
        }
        
        let matrix = getMatrix(geometry.matrix * scale * translate * rotate, dirtyRect.size) //* rotate
        
        outer: for (i, face) in geometry.faces.enumerated() {
            var points = [Vector]()
            
            for i in face {
                guard matrix[i, 3] >= 0 else {
                    continue outer
                }
                points.append(Vector(matrix[i, 0], matrix[i, 1], matrix[i, 2]))
            }
            
            drawFace(points, geometry.colors[i])
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
        
        ModelView.cubeStroke.setStroke()
        
        if let color = color, colorFaces {
            color.setFill()
        } else {
            ModelView.cubeFill.setFill()
        }
        
        path.close()
        path.stroke()
        path.fill()
    }
    
    func getMatrix(_ matrix: Matrix, _ size: CGSize) -> Matrix {
        var result = matrix * camera.matrix * camera.projection
        
        let width = Double(size.width)
        let height = Double(size.height)
        
        for i in 0..<result.rows {
            result[i, 0] = (result[i, 0] * width) / (2.0 * result[i, 3]) + width / 2.0;
            result[i, 1] = (result[i, 1] * height) / (2.0 * result[i, 3]) + height / 2.0;
        }
        
        return result
    }
    
    public func load(_ name: String) {
        guard let file = Bundle.main.path(forResource: name, ofType: "3d") else {
            return
        }
        
        geometry = MKGeometry.fromFile(file)
        
        guard let _ = geometry else {
            return
        }
        
        let center = geometry!.matrix.center
        
        translate = Matrix.identity.translate(-center.x, -center.y, center.z * 2)
        rotate = Matrix.identity
        scale = Matrix.identity
        
        buildGuide()
        
        camera.screenSize = bounds.size
        
        setNeedsDisplay(bounds)
    }
    
    func update() {
        // Translate x
        if let _ = keys[2] {
            translate = translate.translate(2, 0, 0)
        } else if let _ = keys[0] {
            translate = translate.translate(-2, 0, 0)
        }
        
        // Translate y
        if let _ = keys[13] {
            translate = translate.translate(0, 2, 0)
        } else if let _ = keys[1] {
            translate = translate.translate(0, -2, 0)
        }
        
        // Translate z
        if let _ = keys[12] {
            translate = translate.translate(0, 0, 2)
        } else if let _ = keys[14] {
            translate = translate.translate(0, 0, -2)
        }
        
        // Scale up/down
        if let _ = keys[24] {
            scale = scale.scale(1.1, 1.1, 1.1)
        } else if let _ = keys[27] {
            scale = scale.scale(0.9, 0.9, 0.9)
        }
        
        // Rotate x
        if let _ = keys[18] {
            rotate = rotate.rotateX(1)
        }
        
        // Rotate y
        if let _ = keys[19] {
            rotate = rotate.rotateY(1)
        }
        
        // Rotate z
        if let _ = keys[20] {
            rotate = rotate.rotateZ(1)
        }
        
        buildGuide()
        setNeedsDisplay(bounds)
    }
    
    override func keyDown(with event: NSEvent) {
        Swift.print(event.keyCode)
        
        if let _ = keys[event.keyCode] {
            return
        }
        keys[event.keyCode] = true
    }
    
    override func keyUp(with event: NSEvent) {
        if let _ = keys[event.keyCode] {
            keys.removeValue(forKey: event.keyCode)
        }
    }
    
    
}
