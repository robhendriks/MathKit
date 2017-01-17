//
//  Vector.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

public class Vector {
    
    public static let up = Vector(0, 1, 0)
    
    public var x = 0.0
    public var y = 0.0
    public var z = 0.0
    
    public init(_ x: Double, _ y: Double, _ z: Double) {
        set(x, y, z)
    }
    
    public init(_ vector: Vector) {
        set(vector)
    }
    
    public init() {
        
    }
    
    class func add(_ left: Vector, _ right: Vector) -> Vector {
        return Vector(left).add(right)
    }
    
    class func subtract(_ left: Vector, _ right: Vector) -> Vector {
        return Vector(left).subtract(right)
    }
    
    class func multiply(_ left: Vector, _ right: Vector) -> Vector {
        return Vector(left).multiply(right)
    }
    
    public func set(_ x: Double, _ y: Double, _ z: Double) -> Vector {
        self.x = x
        self.y = y
        self.z = z
        return self
    }
    
    public func set(_ vector: Vector) -> Vector {
        return set(vector.x, vector.y, vector.z)
    }
    
    public func set(_ scalar: Double) -> Vector {
        return set(scalar, scalar, scalar)
    }
    
    public func add(_ x: Double, _ y: Double, _ z: Double) -> Vector {
        return set(self.x + x, self.y + y, self.z + z)
    }
    
    public func add(_ vector: Vector) -> Vector {
        return add(vector.x, vector.y, vector.z)
    }
    
    public func add(_ scalar: Double) -> Vector {
        return add(scalar, scalar, scalar)
    }
    
    public func subtract(_ x: Double, _ y: Double, _ z: Double) -> Vector {
        return set(self.x - x, self.y - y, self.z - z)
    }
    
    public func subtract(_ vector: Vector) -> Vector {
        return subtract(vector.x, vector.y, vector.z)
    }
    
    public func subtract(_ scalar: Double) -> Vector {
        return subtract(scalar, scalar, scalar)
    }
    
    public func multiply(_ x: Double, _ y: Double, _ z: Double) -> Vector {
        return set(self.x * x, self.y * y, self.z * z)
    }
    
    public func multiply(_ vector: Vector) -> Vector {
        return multiply(vector.x, vector.y, vector.z)
    }
    
    public func multiply(_ scalar: Double) -> Vector {
        return multiply(scalar, scalar, scalar)
    }
}

extension Vector: CustomStringConvertible {
    
    public var description: String {
        return "Vector(x: \(x), y: \(y), z: \(z))"
    }
    
}

public func +(left: Vector, right: Vector) -> Vector {
    return Vector.add(left, right)
}

public func -(left: Vector, right: Vector) -> Vector {
    return Vector.subtract(left, right)
}

public func *(left: Vector, right: Vector) -> Vector {
    return Vector.multiply(left, right)
}

public func +=(left: Vector, right: Vector) -> Vector {
    return left.add(right)
}

public func -=(left: Vector, right: Vector) -> Vector {
    return left.subtract(right)
}

public func *=(left: Vector, right: Vector) -> Vector {
    return left.multiply(right)
}
