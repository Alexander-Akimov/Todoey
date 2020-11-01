//
//  DataServiceProtocol.swift
//  Todoey
//
//  Created by Akimov on 10/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    associatedtype T

    var count: Int { get }
    func get(by index: Int) -> T
    func add(_ item: T)
    func update(_ item: T, at index: Int)
    func delete(at index: Int)
    //func saveItems()
    func loadItems()
}
