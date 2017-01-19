//
//  ModelCategory.swift
//  macOS Example
//
//  Created by Rob Hendriks on 19/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

class ModelCategory {
    
    var name: String
    var children: [ModelItem]
    
    init(name: String, children: [ModelItem]) {
        self.name = name
        self.children = children
    }
    
    convenience init(name: String) {
        self.init(name: name, children: [ModelItem]())
    }
    
}
