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
    
    public var fieldOfView = 90.0 {
        didSet {
            build()
        }
    }
    
    private(set) public var matrix: Matrix
    private(set) public var projection: Matrix
    
    private var x: Vector
    private var y: Vector
    private var z: Vector
    
    public init(_ eye: Vector, _ lookAt: Vector, _ up: Vector) {
        self.eye = eye
        self.lookAt = lookAt
        self.up = up
        
        self.matrix = Matrix(4, 4)
        self.projection = Matrix(4, 4)
        
        self.x = Vector()
        self.y = Vector()
        self.z = Vector()
        
        build()
    }
    
    public convenience init(_ eye: Vector, _ lookAt: Vector) {
        self.init(eye, lookAt, Vector.up)
    }
    
    private func build() {
        z = (eye - lookAt).normalize
        y = up.normalize
        x = Vector.cross(y, z).normalize
        y = Vector.cross(z, x).normalize
        
        let near = 1.0
        let far = 100.0
        let a = fieldOfView * .pi / 180.0
        let scale = near * tan(a * 0.5)
        
        // Camera matrix
        matrix = Matrix([
            [x.x, x.y, x.z, -Vector.dot(x, eye)],
            [y.x, y.y, y.z, -Vector.dot(y, eye)],
            [z.x, z.y, z.z, -Vector.dot(z, eye)],
            [0, 0, 0, 1]
        ])
        
        // Projection matrix
        projection = Matrix([
            [scale, 0, 0, 0],
            [0, scale, 0, 0],
            [0, 0, -far / (far - near), -1],
            [0, 0, (-far * near) / (far - near), 0]
        ])
        
//        DEBUG
//        print(matrix)
//        print(projection)
    }
}
