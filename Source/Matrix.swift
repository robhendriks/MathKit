//
//  Matrix.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

public struct Matrix {
    
    private(set) public var size: Int
    private(set) public var columns: Int
    private(set) public var rows: Int
    private(set) public var array: [Double]
    
    public init(_ columns: Int, _ rows: Int) {
        self.size = columns * rows
        self.columns = columns
        self.rows = rows
        self.array = Array(repeating: 0.0, count: size)
    }
    
    public init(_ matrix: Matrix) {
        size = matrix.size
        columns = matrix.columns
        rows = matrix.rows
        array = matrix.array
    }
    
    public init(_ matrix: [[Double]]) {
        columns = matrix[0].count
        rows = matrix.count
        size = columns * rows
        array = matrix.flatMap { $0 }
    }
    
    public subscript(index: Int) -> Double {
        get {
            return array[index]
        }
        set {
            array[index] = newValue
        }
    }
    
    public subscript(row: Int) -> [Double] {
        get {
            let start = row * columns
            return Array(array[start..<start + columns])
        }
        set {
            let start = row * columns
            for i in start..<start + columns {
                array[i] = newValue[i]
            }
        }
    }
    
    public subscript(row: Int, column: Int) -> Double {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }
    
    public func translate(_ args: Double...) -> Matrix {
        assert(args.count == columns - 1)
        
        let size = args.count
        var translationMatrix = Matrix(size + 1, size + 1)
        
        for i in 0..<translationMatrix.rows {
            for j in 0..<translationMatrix.columns {
                translationMatrix[i, j] = (j == i ? 1 : 0)
            }
        }
        
        for i in 0..<size {
            translationMatrix[size, i] = args[i]
        }
        
        return self * translationMatrix
    }

    public func scale(_ args: Double...) -> Matrix {
        assert(args.count == columns - 1)
        
        let size = args.count
        var scaleMatrix = Matrix(size + 1, size + 1)
        
        for i in 0..<scaleMatrix.rows {
            for j in 0..<scaleMatrix.columns {
                if j == i {
                    if i < size {
                        scaleMatrix[i, j] = args[i];
                    } else {
                        scaleMatrix[i, j] = 1;
                    }
                } else {
                    scaleMatrix[i, j] = 0
                }
            }
        }
        
        return self * scaleMatrix
    }
    
    public func getRotationX(_ angle: Double) -> Matrix {
        let a = (M_PI / 180.0) * angle
    
        return Matrix([
            [1, 0, 0, 0],
            [0, cos(a), -sin(a), 0],
            [0, sin(a), cos(a), 0],
            [0, 0, 0, 1]
        ])
    }
    
    public func getRotationY(_ angle: Double) -> Matrix {
        let a = (M_PI / 180.0) * angle
        
        return Matrix([
            [cos(a), 0, -sin(a), 0],
            [0, 1, 0, 0],
            [sin(a), 0, cos(a), 0],
            [0, 0, 0, 1]
        ])
    }
    
    public func getRotationZ(_ angle: Double) -> Matrix {
        let a = (M_PI / 180.0) * angle
        
        return Matrix([
            [cos(a), -sin(a), 0, 0],
            [sin(a), cos(a), 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ])
    }
    
    public func rotateX(_ angle: Double) -> Matrix {
        return self * getRotationX(angle)
    }
    
    public func rotateY(_ angle: Double) -> Matrix {
        return self * getRotationY(angle)
    }
    
    public func rotateZ(_ angle: Double) -> Matrix {
        return self * getRotationZ(angle)
    }
    
}

extension Matrix: CustomStringConvertible {
    
    public var description: String {
        var str = ""
        for i in stride(from: 0, to: size, by: columns) {
            str += "["
            for j in 0..<columns {
                str += String(array[i + j])
                if j < columns - 1 {
                    str += " "
                }
            }
            str += "]\n"
        }
        return str
    }
    
}

extension Matrix {
    
    public static func * (left: Matrix, right: Matrix) -> Matrix {
        assert(left.columns == right.rows)
        
        var product = Matrix(right.columns, left.rows)
        
        for i in 0..<left.rows {
            for j in 0..<right.columns {
                for k in 0..<left.columns {
                    product[i, j] += left[i, k] * right[k, j];
                }
            }
        }
        
        return product
    }
    
}

extension Matrix {
    
    public static func *= (left: inout Matrix, right: Matrix) {
        left = left * right
    }
    
}
