//
//  ModelViewController.swift
//  macOS Example
//
//  Created by Rob Hendriks on 19/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Cocoa

class ModelsViewController: NSViewController {
    
    var folderImage: NSImage?
    var documentImage: NSImage?
    
    var categories = [ModelCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folderImage = NSImage(named: "Folder")
        documentImage = NSImage(named: "Document")
        
        loadCategories()
    }
    
    func loadCategories() {
        guard let file = Bundle.main.path(forResource: "Models", ofType: "plist"),
            let modelList = NSArray(contentsOfFile: file) else {
            return
        }
        
        for modelItem in modelList {
            guard let dict = modelItem as? NSDictionary,
                let categoryName = dict["Category"] as? String,
                let modelName = dict["Name"] as? String else {
                continue
            }
            
            if !categories.contains(where: { $0.name == categoryName }) {
                categories.append(ModelCategory(name: categoryName))
            }
            
            if let category = categories.first(where: { $0.name == categoryName }) {
                category.children.append(ModelItem(name: modelName))
            }
        }
    }
    
}

extension ModelsViewController: NSOutlineViewDataSource {
 
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let category = item as? ModelCategory {
            return category.children.count
        }
        return categories.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let category = item as? ModelCategory {
            return category.children[index]
        }
        return categories[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let category = item as? ModelCategory {
            return category.children.count > 0
        }
        return false
    }
    
}

extension ModelsViewController: NSOutlineViewDelegate {
 
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        switch item {
        case let category as ModelCategory:
            let view = outlineView.make(withIdentifier: "DataCell", owner: self) as? NSTableCellView
            
            if let textField = view?.textField {
                textField.stringValue = category.name
            }
            if let imageView = view?.imageView {
                imageView.image = folderImage
            }
            
            return view
        case let model as ModelItem:
            let view = outlineView.make(withIdentifier: "DataCell", owner: self) as? NSTableCellView
            
            if let textField = view?.textField {
                textField.stringValue = model.name
            }
            if let imageView = view?.imageView {
                imageView.image = documentImage
            }
            
            return view
        default:
            return nil
        }
    }
    
}
