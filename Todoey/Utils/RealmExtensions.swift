//
//  RealmExtensions.swift
//  Todoey
//
//  Created by Akimov on 11/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {

    func cascadeDelete(_ entity: [Object]) {

        var toBeDeleted = Set(entity)

        while let element = toBeDeleted.popFirst() {
            guard !element.isInvalidated, element.realm != nil else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
            delete(element)
        }
    }

    private func resolve(element: Object, toBeDeleted: inout Set<Object>) {

        func foundChild(entity: Object) {
            toBeDeleted.insert(entity)
        }

        func foundChild(list: RealmSwift.ListBase) {
            (0..<list._rlmArray.count)
                .map(list._rlmArray.object)
                .compactMap { $0 as? Object }
                .forEach(foundChild)
        }

        element
            .objectSchema
            .properties
            .map(\.name)
            .compactMap(element.value(forKey:))
            .forEach { value in
                if let entity = value as? Object {
                    foundChild(entity: entity)
                } else if let list = value as? RealmSwift.ListBase {
                    foundChild(list: list)
                }
            }
    }
}
