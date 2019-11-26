//
//  Helper.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import Foundation
import RealmSwift

class Helper {
    
    static let configRealm = Realm.Configuration(schemaVersion: 1, migrationBlock: { _, _ in})
    static let realm = try! Realm()
    
    static func getIdForCar() -> Int {
        if let maxValue = realm.objects(Car.self).max(ofProperty: "id") as Int? {
            return maxValue + 1
        } else {
            return 1
        }
    }
    
}
