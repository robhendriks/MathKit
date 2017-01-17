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
    
    func testDivide() {
        let vec = Vector(4, 5, 6) / Vector(1, 2, 3)
        
        XCTAssertEqual(vec.x, 4)
        XCTAssertEqual(vec.y, 2.5)
        XCTAssertEqual(vec.z, 2)
    }
    
    func testEquality() {
        let a = Vector(1, 2, 3)
        let b = Vector(1, 2, 3)
        let c = Vector(3, 2, 1)
        
        XCTAssertTrue(a == b)
        XCTAssertFalse(a != b)
        
        XCTAssertTrue(a != c)
        XCTAssertFalse(a == c)
    }
    
    func testCrossProduct() {
        let vec = Vector.cross(Vector(1, 2, 3), Vector(4, 5, 6))
        
        XCTAssertEqual(vec.x, -3)
        XCTAssertEqual(vec.y, 6)
        XCTAssertEqual(vec.z, -3)
    }
    
    func testDotProduct() {
        let dot = Vector.dot(Vector(1, 2, 3), Vector(4, 5, 6))
        XCTAssertEqual(dot, 32)
    }
    
    func testLength() {
        let length = Vector(4, 5, 6).length
        XCTAssertEqualWithAccuracy(length, 8.774, accuracy: 0.001)
    }
    
    func testNormalize() {
        let vec = Vector(3, 1, 2).normalize
        
        XCTAssertEqualWithAccuracy(vec.x, 0.802, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(vec.y, 0.267, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(vec.z, 0.534, accuracy: 0.001)
    }
}
