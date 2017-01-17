//
//  Vector.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

public struct Vector {
    
    public var x = 0.0
    public var y = 0.0
    public var z = 0.0
    
    public var length: Double {
        return sqrt(x * x + y * y + z * z)
    }
    
    public var normalize: Vector {
        let l = length
        return Vector(x / l, y / l, z / l)
    }
    
    public init(_ x: Double, _ y: Double, _ z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ vector: Vector) {
        self.init(vector.x, vector.y, vector.z)
    }
    
    public static func dot(_ a: Vector, _ b: Vector) -> Double {
        return a.x * b.x + a.y * b.y + a.z * b.z
    }
    
    public static func cross(_ a: Vector, _ b: Vector) -> Vector {
        return Vector(a.y * b.z - a.z * b.y,
                      a.z * b.x - a.x * b.z,
                      a.x * b.y - a.y * b.x)
    }
    
}

extension Vector: CustomStringConvertible {
    
    public var description: String {
        return "Vector(x: \(x), y: \(y), z: \(z))"
    }
    
}

extension Vector {
    
    public static func + (left: Vector, right: Vector) -> Vector {
        return Vector(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    public static func - (left: Vector, right: Vector) -> Vector {
        return Vector(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    public static func * (left: Vector, right: Vector) -> Vector {
        return Vector(left.x * right.x, left.y * right.y, left.z * right.z)
    }

    public static func / (left: Vector, right: Vector) -> Vector {
        return Vector(left.x / right.x, left.y / right.y, left.z / right.z)
    }
    
}

extension Vector {
    
    public static func += (left: inout Vector, right: Vector) {
        left = left + right
    }
    
    public static func -= (left: inout Vector, right: Vector) {
        left = left - right
    }
    
    public static func *= (left: inout Vector, right: Vector) {
        left = left * right
    }
    
    public static func /= (left: inout Vector, right: Vector) {
        left = left / right
    }
    
}

extension Vector {
    
    public static func == (left: Vector, right: Vector) -> Bool {
        return (left.x == right.x) && (left.y == right.y) && (left.z == right.z)
    }
    
    public static func != (left: Vector, right: Vector) -> Bool {
        return !(left == right)
    }
    
}
