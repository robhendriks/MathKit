//
//  MKCamera.swift
//  macOS Example
//
//  Created by Rob Hendriks on 18/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import MathKit

class MKCamera {
    public var eye: Vector {
        didSet {
            build()
        }
    }
    
    public var lookAt: Vector {
        didSet {
            build()
        }
    }
    
    public var up: Vector {
        didSet {
            build()
        }
    }
    
    public var fieldOfView = 60.0 {
        didSet {
            build()
        }
    }
    
    public var screenSize: CGSize {
        didSet {
            build()
        }
    }
    
    private(set) public var matrix: Matrix
    private(set) public var projection: Matrix
    
    public init(_ eye: Vector, _ lookAt: Vector, _ up: Vector, _ screenSize: CGSize) {
        self.eye = eye
        self.lookAt = lookAt
        self.up = up
        self.screenSize = screenSize
        
        self.matrix = Matrix(4, 4)
        self.projection = Matrix(4, 4)
        
        build()
    }
    
    public convenience init(_ eye: Vector, _ lookAt: Vector, _ screenSize: CGSize) {
        self.init(eye, lookAt, Vector.up, screenSize)
    }
    
    public static func fps(_ eye: Vector, _ pitch: Double, _ yaw: Double) -> Matrix {
        let cosPitch = cos(pitch.toRadians)
        let sinPitch = sin(pitch.toRadians)
        let cosYaw = cos(yaw.toRadians)
        let sinYaw = sin(yaw.toRadians)
        
        let x = Vector(cosYaw, 0, -sinYaw)
        let y = Vector(sinYaw * sinPitch, cosPitch, cosYaw * sinPitch)
        let z = Vector(sinYaw * cosPitch, -sinPitch, cosPitch * cosYaw)
 
        return Matrix([
            [x.x, y.x, z.x, 0],
            [x.y, y.y, z.y, 0],
            [x.z, y.z, z.z, 0],
            [-Vector.dot(x, eye), -Vector.dot(y, eye), -Vector.dot(z, eye), 1]
        ])
    }
    
    public static func lookAt(_ eye: Vector, _ lookAt: Vector, _ up: Vector) -> Matrix {
        let z = (eye - lookAt).normalize
        let x = Vector.cross(up, z).normalize
        let y = Vector.cross(z, x)

        return Matrix([
            [x.x, x.y, x.z, -Vector.dot(x, eye)],
            [y.x, y.y, y.z, -Vector.dot(y, eye)],
            [z.x, z.y, z.z, -Vector.dot(z, eye)],
            [0, 0, 0, 1]
        ])
    }
    
    public func build() {
//        matrix = MKCamera.fps(Vector(0, 0, -100), 0, 00)
        matrix = MKCamera.lookAt(eye, lookAt, up)
        
        // Projection Matrix
        let ratio = Double(screenSize.width / screenSize.height)
        let near = 1.0
        let far = 100.0
        let range = near - far
        let fov = tan(fieldOfView.toRadians / 2.0)
        
        projection = Matrix([
            [1.0 / (fov * ratio), 0, 0, 0],
            [0, 1.0 / fov, 0, 0],
            [0, 0, (-near - far) / range, 2.0 * far * near / range],
            [0, 0, 1.0, 0]
        ])
        
//        DEBUG
//        print(matrix)
//        print(projection)
    }
}
