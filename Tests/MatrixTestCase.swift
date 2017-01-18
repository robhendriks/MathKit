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
    
    func testMultiply() {
        let a = Matrix([
            [0, 3, 5],
            [5, 5, 2]
        ])
        let b = Matrix([
            [3, 4],
            [3, -2],
            [4, -2]
        ])
        let c = a * b
        
        XCTAssertEqual(c[0,0], 29)
        XCTAssertEqual(c[0,1], -16)
        XCTAssertEqual(c[1,0], 38)
        XCTAssertEqual(c[1,1], 6)
    }
    
}
