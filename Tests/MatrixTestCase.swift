//
//  MatrixTestCase.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

@testable import MathKit
import XCTest

class MatrixTestCase: XCTestCase {
    
    func testExample() {
        let m = Matrix([
            [0, 3, 5],
            [5, 5, 2]
        ])
        print(m.array)
    }
    
}
