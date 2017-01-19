//
//  Int+Radians.swift
//  MathKit
//
//  Created by Rob Hendriks on 20/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

extension Int {
    
    public var toRadians: Double {
        return Double(self) * .pi / 180
    }
    
    public var toDegrees: Double {
        return Double(self) * 180 / .pi
    }
    
}

extension FloatingPoint {
    
    public var toRadians: Self {
        return self * .pi / 180
    }
    
    public var toDegrees: Self {
        return self * 180 / .pi
    }
    
}
