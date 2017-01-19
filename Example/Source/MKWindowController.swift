//
//  MKWindowController.swift
//  macOS Example
//
//  Created by Rob Hendriks on 18/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

class MKWindowController: NSWindowController {
    
    override func windowDidLoad() {
        window?.titleVisibility = .hidden
    }
    
    @IBAction func collapseSidebar(_ sender: Any) {
        guard let splitViewController = contentViewController as? NSSplitViewController else {
            return
        }
        
        let splitViewItem = splitViewController.splitViewItems[0]
        splitViewItem.animator().isCollapsed = !splitViewItem.animator().isCollapsed
    }
    
    @IBAction func fieldOfViewChanged(_ sender: Any) {
        guard let segmentedControl = sender as? NSSegmentedControl,
            let splitViewController = contentViewController as? NSSplitViewController,
            let modelViewController = splitViewController.splitViewItems[1].viewController as? ModelViewController else {
            return
        }
        
        let index = Double(segmentedControl.selectedSegment)
        let fov = 60.0 + (index * 30.0)
        
        if let modelView = modelViewController.modelView {
            modelView.camera.fieldOfView = fov
            modelView.setNeedsDisplay(modelView.bounds)
        }
    }
    
    @IBAction func toggleColors(_ sender: Any) {
        guard let splitViewController = contentViewController as? NSSplitViewController,
            let modelViewController = splitViewController.splitViewItems[1].viewController as? ModelViewController,
            let modelView = modelViewController.modelView else {
                return
        }
        
        modelView.colorFaces = !modelView.colorFaces
    }
}
