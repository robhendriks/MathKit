//
//  Matrix.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

public struct Matrix {
    
    private(set) public var array: [[Int]]!
    
    public init() {
        
    }
    
    public init(matrix: Matrix) {
        
    }
    
}

extension Matrix: CustomStringConvertible {
    
    public var description: String {
        return "Matrix()"
    }
    
}
