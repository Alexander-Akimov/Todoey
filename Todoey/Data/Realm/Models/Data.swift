//
//  Data.swift
//  Todoey
//
//  Created by Akimov on 10/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class MyData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
