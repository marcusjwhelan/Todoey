//
//  Item.swift
//  Todoey
//
//  Created by Marcus Whelan on 7/25/18.
//  Copyright © 2018 Marcus Whelan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    // item to category - many to one
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
