//
//  Category.swift
//  Todoey
//
//  Created by Marcus Whelan on 7/25/18.
//  Copyright © 2018 Marcus Whelan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    // relationship - item , one to many
    let items = List<Item>()
}
