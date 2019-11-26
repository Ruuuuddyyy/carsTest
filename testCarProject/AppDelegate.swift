//
//  AppDelegate.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Realm.Configuration.defaultConfiguration = Helper.configRealm
        
        if !UserDefaults.standard.bool(forKey: "storageFilled") {
            UserDefaults.standard.set(true, forKey: "storageFilled")
            fillCarsStorage()
        }
        
        return true
    }
    
    private func fillCarsStorage() {
        
        let bmwCar = Car()
        bmwCar.releaseYear = "1997"
        bmwCar.carClass = "BMW"
        bmwCar.carModel = "5 серия"
        bmwCar.manufacturer = "Германия"
        bmwCar.bodyType = "Седан"
        bmwCar.id = 1
        bmwCar.imageData = UIImage(named: "bmw")?.jpegData(compressionQuality: 1)
        
        let kiaCar = Car()
        kiaCar.releaseYear = "2019"
        kiaCar.carClass = "KIA"
        kiaCar.carModel = "Sportage"
        kiaCar.manufacturer = "Южная корея"
        kiaCar.bodyType = "Внедорожник"
        kiaCar.id = 2
        kiaCar.imageData = UIImage(named: "kia")?.jpegData(compressionQuality: 1)

        let mazdaCar = Car()
        mazdaCar.releaseYear = "2008"
        mazdaCar.carClass = "Mazda"
        mazdaCar.carModel = "6 модель"
        mazdaCar.manufacturer = "Япония"
        mazdaCar.bodyType = "Седан"
        mazdaCar.id = 3
        mazdaCar.imageData = UIImage(named: "mazda")?.jpegData(compressionQuality: 1)

        let cars = [bmwCar, mazdaCar, kiaCar]
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(cars)
        }

    }

}

