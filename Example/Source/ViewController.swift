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

    @IBOutlet weak var theView: MKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        theView.becomeFirstResponder()
    }

}

