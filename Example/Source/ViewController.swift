//
//  ViewController.swift
//  macOS Example
//
//  Created by Rob Hendriks on 17/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa
import MathKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = Matrix([
            [10, 10, 10, 1],
            [10, 10, 10, 1],
            [10, 10, 10, 1],
            [10, 10, 10, 1]
        ])
        var b = Matrix([
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ])
        
        b *= a
        
        print(a)
        print(b)
    }

    override var representedObject: Any? {
        didSet {
        }
    }

}

