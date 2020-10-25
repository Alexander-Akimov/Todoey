//
//  CategoriesDataService.swift
//  Todoey
//
//  Created by Akimov on 10/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoriesDataService: BaseDataService<Category>, DataServiceProtocol {

    typealias T = CategoryDTO

    private var ts = TranslationService()

    func getItem(by index: Int) -> CategoryDTO {
        return items[index].toDto()
    }

    func getEntity(by index: Int) -> Category? {
        guard index < items.count, index >= 0 else { return nil }
        return items[index]
    }

    func addItem(_ dto: CategoryDTO) {
        let category = dto.toEntity(with: context)
        items.append(category)
    }

    func updateItem(_ dto: CategoryDTO, at index: Int) {
        let category = items[index]
        category.name = dto.name
    }

    func deleteItem(at index: Int) {
        let item = items[index]
        items.remove(at: index)
        context.delete(item)
    }
}
