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

class ItemsDataService: DataServiceProtocol {

    typealias T = TodoItemDTO

    private var itemsArray = [Item]()
    private var ts = TranslationService()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getItemsCount() -> Int {
        return itemsArray.count
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        do {
//            return try context.count(for: request)
//        } catch {
//            print("Error saving context \(error)")
//        }
    }

    func getItem(by index: Int) -> TodoItemDTO? {
        return ts.translate(from: itemsArray[index])
    }

    func addItem(_ todoItem: TodoItemDTO) {
        if let item = ts.translate(from: todoItem, with: context) {
            itemsArray.append(item)
        }
    }

    func updateItem(_ todoItem: TodoItemDTO, at index: Int) {
        let item = itemsArray[index]
        item.done = todoItem.isDone
        item.title = todoItem.title
    }

    func deleteItem(at index: Int) {
        let item = itemsArray[index]
        itemsArray.remove(at: index)
        context.delete(item)
    }

    func searchItems(by text: String) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadItems(with: request)
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }

    func loadItems() {
        loadItems(with: Item.fetchRequest())
    }

    private func loadItems(with request: NSFetchRequest<Item>) {
        do {
            self.itemsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
