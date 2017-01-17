//
//  VectorTestCase.swift
//  MathKit
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

@testable import MathKit
import XCTest

class VectorTestCase: XCTestCase {
    
    func testSet() {
        let vec = Vector().set(1, 2, 3)
        XCTAssertEqual(vec.x, 1)
        XCTAssertEqual(vec.y, 2)
        XCTAssertEqual(vec.z, 3)
    }
    
    func testAdd() {
        let vec = Vector(1, 2, 3) + Vector(4, 5, 6)
        
        XCTAssertEqual(vec.x, 5)
        XCTAssertEqual(vec.y, 7)
        XCTAssertEqual(vec.z, 9)
    }
    
    func testSubtract() {
        let vec = Vector(4, 5, 6) - Vector(3, 2, 1)
        XCTAssertEqual(vec.x, 1)
        XCTAssertEqual(vec.y, 3)
        XCTAssertEqual(vec.z, 5)
    }
    
    func testMultiply() {
        let vec = Vector(1, 2, 3) * Vector(4, 5, 6)
        XCTAssertEqual(vec.x, 4)
        XCTAssertEqual(vec.y, 10)
        XCTAssertEqual(vec.z, 18)
    }
    
}
