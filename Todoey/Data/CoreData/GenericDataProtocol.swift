//
//  GenericDataProtocol.swift
//  Todoey
//
//  Created by Akimov on 10/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol GenericDataProtocol {
    associatedtype T

    func getItemsCount() -> Int
    func getItem(by index: Int) -> T
    func addItem(_ item: T)
    func updateItem(_ item: T, at index: Int)
    func deleteItem(at index: Int)
    //func saveItems()
    func loadItems()
}
