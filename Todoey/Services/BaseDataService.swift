//
//  BaseDataService.swift
//  Todoey
//
//  Created by Akimov on 10/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import RealmSwift
import UIKit


class BaseDataService<T> where T: Object {

    let realm: Realm

    var items: Results<T>?

    init() {
        Self.initRealm()
        realm = try! Realm()
    }

    func get(by index: Int) -> T? {
        return items?[index]
    }

    var count: Int { items?.count ?? 1 }

    func getObject(by index: Int) -> T? {
        guard let items = items else { return nil }
        guard index < items.count, (index >= 0) else { return nil }
        return items[index]
    }

    func delete (at index: Int) {
        guard let item = items?[index] else { return }
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Error deleting items, \(error)")
        }
    }

    func save(item: T) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error adding new items, \(error)")
        }
    }

    func loadItems() {
        self.items = realm.objects(T.self)
    }

    private static func initRealm() {
        //        var key = Data(count: 64)
        //
        //        _ = key.withUnsafeMutableBytes { bytes in
        //            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        //        }
        //        let temp = key.hexEncodedString()
        //
        let config = Realm.Configuration(
            //            encryptionKey: key,
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
                        newObject![K.Item.dateCreated] = Date(timeIntervalSinceNow: 50000)
                    }
                }
            }
        )
        //        config.deleteRealmIfMigrationNeeded = true

        Realm.Configuration.defaultConfiguration = config

        //_ = try! Realm()
    }

//    internal func loadItems(with request: NSFetchRequest<T>? = nil, predicate: NSPredicate? = nil) {
//
//        let newReq = request ?? NSFetchRequest<T>(entityName: T.entity().name!)
//
//        let res = [newReq.predicate, predicate].compactMap { $0 }
//
//        if res.count > 0 {
//            newReq.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: res)
//        }
//
//        do {
//            self.items = try context.fetch(newReq)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
}
