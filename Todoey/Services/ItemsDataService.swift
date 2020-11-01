//
//  DataService.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class ItemsDataService: BaseDataService<Item>, DataServiceProtocol {

    typealias T = TodoItemDTO
    private var ts = TranslationService()

    var selectedCategory: Category?

    func get(by index: Int) -> TodoItemDTO {
        guard let item = get(by: index) else { return TodoItemDTO.empty }
        return ts.translate(from: item)
    }

    func add(_ todoItem: TodoItemDTO) {
        do {
            try realm.write {
                if let item = ts.translate(from: todoItem), let cat = selectedCategory {
                    cat.items.append(item)
                    realm.add(item)
                }
            }
        } catch {
            print("Error adding new items, \(error)")
        }
    }

    func update(_ todoItem: TodoItemDTO, at index: Int) {
        guard let item = get(by: index) else { return }

        do {
            try realm.write {
                item.done = todoItem.isDone
            }
        } catch {
            print("Error updating \(error)")
        }
    }

    override func loadItems() {
        self.items = selectedCategory?.items
        //.sorted(byKeyPath: K.Item.title, ascending: true)
        .sorted(byKeyPath: K.Item.dateCreated, ascending: false)
    }

    func searchItems(by text: String) {
        let predicate = NSPredicate(format: "\(K.Item.title) CONTAINS[cd] %@", text)
        items = items?.filter(predicate)
        //.sorted(byKeyPath: "title", ascending: true)
        .sorted(byKeyPath: K.Item.dateCreated, ascending: true)

//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
//
//        loadItemsTemp(with: request)
    }

//    private func loadItemsTemp(with request: NSFetchRequest<Item>? = nil) {
//
//        guard let cat = selectedCategory else { return }
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", cat.name!)
//
//        loadItems(with: request, predicate: categoryPredicate)
    //  }

    func test() {
        //        let data = MyData()
        //        data.name = "Angela"
        //        data.age = 31

                /*     do {
                    let realm = try Realm()
        //            try realm.write {
        //                realm.add(data)
        //            }

                } catch {
                    print("Error initialising new realm, \(error)")
                }*/
    }
}
