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

        let a = Vector(10, 10, 10)
        let b = Vector(1, 2, 3)
        let c = a * b
        
        print(a, b, c)
        
    }

    override var representedObject: Any? {
        didSet {
        }
    }

}

