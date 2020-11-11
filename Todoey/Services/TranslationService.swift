//
//  TranslationService.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreData

extension Category {

    func toDto() -> CategoryDTO {
        return CategoryDTO(name: self.name, bgColorHex: self.bgColorHex)
    }
}

extension CategoryDTO {

    func toRealmObject() -> Category {
        let category = Category()
        category.name = self.name
        category.bgColorHex = self.bgColorHex
        return category
    }
}

class TranslationService {


    func translate(from item: Item) -> TodoItemDTO {
//        guard let item = item else { return nil }

        return TodoItemDTO(title: item.title, isDone: item.done)
    }

    func translate(from dto: TodoItemDTO?) -> Item? {
        guard let dto = dto else { return nil }

        let item = Item()
        item.title = dto.title
        item.done = dto.isDone
        item.dateCreated = dto.dateCreated

        return item
    }

    func toUnsavedCoreData(from dtos: [TodoItemDTO], with context: NSManagedObjectContext) -> [Item] {
        let items = dtos.compactMap { dto in translate(from: dto) }

        return items
    }

    func toTodoItemsDTOs(from items: [Item]) -> [TodoItemDTO] {
        let dtos = items.compactMap { translate(from: $0) }

        return dtos
    }
}
