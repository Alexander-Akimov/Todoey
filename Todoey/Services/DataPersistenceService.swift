//
//  DataPersistenceService.swift
//  Todoey
//
//  Created by Akimov on 10/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


class DataPersistenceService {

     //let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.plistFileName)

    private var itemsArray = [TodoItemDTO]()

    //let defaults = UserDefaults.standard

    init() {
        // print(dataFilePath)
//         itemsArray.append(contentsOf: [
        //            TodoItem(title: "Find Mike", isDone: true),
        //            TodoItem(title: "Buy Eggos", isDone: false),
        //            TodoItem(title: "Clean the room", isDone: true)
        //        ])
        //        if let items = defaults.array(forKey: "TodoeyListArray") as? [String] {
        //            itemsArray = items
        //        }
    }

    func getItemsCount() -> Int {
        return itemsArray.count
    }

    // MARK: - Model Manipulation Methods

    func getItem(by index: Int) -> TodoItemDTO {
        return itemsArray[index]
    }

    func addItem(_ todoItem: TodoItemDTO) {
        //    self.defaults.setValue(self.itemsArray, forKeyPath: "TodoeyListArray")
        self.itemsArray.append(todoItem)
    }

    func updateItem(_ todoItem: TodoItemDTO, at index: Int) {
        itemsArray[index] = todoItem
    }

    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemsArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print(String(format: K.Errors.encode, error.localizedDescription))
        }
    }

    func loadItems() {
        guard let data = try? Data(contentsOf: dataFilePath!) else { return }

        let decoder = PropertyListDecoder()
        do {
            itemsArray = try decoder.decode([TodoItemDTO].self, from: data)
        } catch {
            print(String(format: K.Errors.decode, error.localizedDescription))
        }
    }
}
