//
//  CategoryDTO.swift
//  Todoey
//
//  Created by Akimov on 10/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct CategoryDTO {
    let name: String
    let bgColorHex: String
}
extension CategoryDTO {
    static var empty = CategoryDTO(name: "No Categories Added", bgColorHex: "")
}
