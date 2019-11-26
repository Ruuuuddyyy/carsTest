//
//  MainCarCell.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import UIKit

class MainCarCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var carClassLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var countryCarLabel: UILabel!
    @IBOutlet weak var releaseDateCarLabel: UILabel!
    @IBOutlet weak var bodyTypeCarLabel: UILabel!

    func fillCell(car: Car) {
        
        self.carClassLabel.text = "Класс: " + car.carClass
        self.carModelLabel.text = "Модель: " + car.carModel
        self.countryCarLabel.text = "Производитель: " + car.manufacturer
        self.bodyTypeCarLabel.text = "Тип: " + car.bodyType
        self.releaseDateCarLabel.text = "Год производства: " + car.releaseYear
        
        if let data = car.imageData {
            photoImageView.image = UIImage(data: data)
        } else {
            self.photoImageView.image = UIImage(named: "carIcon")
        }
        
        installViews()
    }
    
    func installViews() {
        self.photoImageView.layer.cornerRadius = 5
        
    }
    
}
