//
//  DetailViewController.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import UIKit
import RealmSwift

enum DetailMode {
    case save
    case add
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var classCarTextField: UITextField!
    @IBOutlet weak var modelCarTextField: UITextField!
    @IBOutlet weak var countryCarTextField: UITextField!
    @IBOutlet weak var ReleaseDateCarTextField: UITextField!
    @IBOutlet weak var bodyTypeTextField: UITextField!
    
    var car: Car?
    let realm = try! Realm()
    var vcDetailMode: DetailMode = .add
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = vcDetailMode == .add ? "Добавить автомобиль" : "Инфо автомобиля"
        self.navigationController?.navigationBar.prefersLargeTitles = false

        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveCarAction))
        self.navigationItem.rightBarButtonItem = saveButton
        
        viewInstall()
    }
    
    @objc func saveCarAction() {
        
        if vcDetailMode == .add {
            self.car = Car()
            self.car?.id = Helper.getIdForCar()
        }
        
        try! realm.write {
            self.car?.carClass = classCarTextField.text!
            self.car?.carModel = modelCarTextField.text!
            self.car?.manufacturer = countryCarTextField.text!
            self.car?.releaseYear = ReleaseDateCarTextField.text!
            self.car?.bodyType = bodyTypeTextField.text!
            self.car?.imageData = photoButton.imageView?.image?.jpegData(compressionQuality: 1)
        }
        
        if let detailCar = self.car {
            try! realm.write {
                if let objectInStorage = realm.objects(Car.self).first(where: {$0.id == detailCar.id}) {
                    objectInStorage.bodyType = detailCar.bodyType
                    objectInStorage.carModel = detailCar.carModel
                    objectInStorage.carClass = detailCar.carClass
                    objectInStorage.manufacturer = detailCar.manufacturer
                    objectInStorage.releaseYear = detailCar.releaseYear
                    objectInStorage.imageData = detailCar.imageData
                    realm.add(objectInStorage)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    realm.add(detailCar)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func viewInstall() {
        self.photoButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let carObject = self.car else { return }
        
        self.classCarTextField.text = carObject.carClass
        self.modelCarTextField.text = carObject.carModel
        self.countryCarTextField.text = carObject.manufacturer
        self.ReleaseDateCarTextField.text = carObject.releaseYear
        self.bodyTypeTextField.text = carObject.bodyType
        
        if let data = carObject.imageData, let img = UIImage(data: data) {
            self.photoButton.setImage(img, for: .normal)
            self.photoButton.contentMode = .scaleAspectFill
        }
        
    }
    
    @IBAction func photoAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

}

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoButton.setImage(pickedImage, for: .normal)
            self.photoButton.layer.cornerRadius = 15
            self.photoButton.contentMode = .scaleAspectFill
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
