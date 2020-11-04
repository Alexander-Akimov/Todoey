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

    func get(by index: Int) -> CategoryDTO {
        guard let item = items?[index] else { return CategoryDTO.empty }
        return item.toDto()
    }

    func add(_ dto: CategoryDTO) {
        let category = dto.toRealmObject()
        save(item: category)
    }

    func update(_ dto: CategoryDTO, at index: Int) {
//        let category = items[index]
//        category.name = dto.name
    }

    override func delete(at index: Int) {
        
        guard let item = items?[index] else { return }

        do {
            try realm.write {
                for element in item.items {
                    realm.delete(element)
                }                
                realm.delete(item)
            }
        } catch {
            print("Error deleting items, \(error)")
        }

    }
}
