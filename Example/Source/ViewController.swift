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
    @IBOutlet weak var fovSlider: NSSlider!
    
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

    @IBAction func cubeSelected(_ sender: Any) {
        theView.load("Cube")
    }
    
    @IBAction func pyramidSelected(_ sender: Any) {
        theView.load("Pyramid")
    }
    
    @IBAction func prismSelected(_ sender: Any) {
        theView.load("Prism")
    }
    
    @IBAction func planeSelected(_ sender: Any) {
        theView.load("Plane")
    }
    
    @IBAction func steveSelected(_ sender: Any) {
        theView.load("Steve")
    }
    
    @IBAction func fovChanged(_ sender: Any) {
        theView.camera.fieldOfView = Double(fovSlider.floatValue)
        theView.setNeedsDisplay(theView.bounds)
    }
}

