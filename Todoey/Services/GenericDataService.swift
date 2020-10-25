//
//  GenericDataService.swift
//  Todoey
//
//  Created by Akimov on 10/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class GenericDataService<T>: DataServiceProtocol where T: NSManagedObject {

    var itemsArray = [T]()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getItemsCount() -> Int {
        return itemsArray.count
    }

    func getItem(by index: Int) -> T {
        return itemsArray[index]
    }

    func addItem(_ item: T) {
        itemsArray.append(item)
    }

    func updateItem(_ todoItem: T, at index: Int) {

    }

    func deleteItem(at index: Int) {
        let item = itemsArray[index]
        itemsArray.remove(at: index)
        context.delete(item)
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }

    func loadItems() {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entity().name!)
        loadItems(with: request)
    }

    private func loadItems(with request: NSFetchRequest<T>) {
        do {
            self.itemsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
