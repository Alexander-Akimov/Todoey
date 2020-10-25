//
//  DataService.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ItemsDataService: BaseDataService<Item>, DataServiceProtocol {

    typealias T = TodoItemDTO
    private var ts = TranslationService()

    var selectedCategory: Category?

    func getItem(by index: Int) -> TodoItemDTO {
        return ts.translate(from: items[index])
    }

    func addItem(_ todoItem: TodoItemDTO) {
        if let item = ts.translate(from: todoItem, with: context) {
            item.parentCategory = selectedCategory
            items.append(item)
        }
    }

    func updateItem(_ todoItem: TodoItemDTO, at index: Int) {
        let item = items[index]
        item.done = todoItem.isDone
        item.title = todoItem.title
    }

    func deleteItem(at index: Int) {
        let item = items[index]
        items.remove(at: index)
        context.delete(item)
    }

    func searchItems(by text: String) {

        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)

        loadItemsTemp(with: request)
    }
    
    private func loadItemsTemp(with request: NSFetchRequest<Item>? = nil) {
        
        guard let cat = selectedCategory else { return }
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", cat.name!)
        
        loadItems(with: request, predicate: categoryPredicate)
    }

    func loadCategoryItems() {
        loadItemsTemp()
    }
}
