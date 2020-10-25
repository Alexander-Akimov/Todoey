//
//  BaseDataService.swift
//  Todoey
//
//  Created by Akimov on 10/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import CoreData
import UIKit

class BaseDataService<T> where T: NSManagedObject {

    var items = [T]()

    internal let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getItemsCount() -> Int {
        return items.count
    }

    func getCount() -> Int {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entity().name!)
        var count = 0

        do {
            count = try context.count(for: request)
        } catch {
            print("Error saving context \(error)")
        }
        return count
    }

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }

    func loadItems() {
        loadItems(with: nil)
    }

    internal func loadItems(with request: NSFetchRequest<T>? = nil, predicate: NSPredicate? = nil) {

        let newReq = request ?? NSFetchRequest<T>(entityName: T.entity().name!)

        let res = [newReq.predicate, predicate].compactMap { $0 }

        if res.count > 0 {
            newReq.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: res)
        }

        do {
            self.items = try context.fetch(newReq)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
