//
//  Car.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import Foundation
import RealmSwift

class Car: Object {
    
    @objc dynamic var releaseYear = ""
    @objc dynamic var carClass = ""
    @objc dynamic var manufacturer = ""
    @objc dynamic var carModel = ""
    @objc dynamic var bodyType = ""
    @objc dynamic var id = 0
    @objc dynamic var imageData: Data?
    
}
