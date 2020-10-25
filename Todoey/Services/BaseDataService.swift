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

    internal func loadItems(with request: NSFetchRequest<T>) {
        do {
            self.items = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
