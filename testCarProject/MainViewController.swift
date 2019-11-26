//
//  MainViewController.swift
//  testCarProject
//
//  Created by Артем Власенко on 25.11.2019.
//  Copyright © 2019 Артем Власенко. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var carsArray = [Car]()
    var selectedCar: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Автомобили"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carsArray = realm.objects(Car.self).filter({ (car) -> Bool in return true })
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            vc.car = selectedCar
            vc.vcDetailMode = selectedCar == nil ? .add : .save
            self.selectedCar = nil
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCarCell", for: indexPath) as! MainCarCell
        cell.fillCell(car: carsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCar = carsArray[indexPath.row]
        performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                let id = self.carsArray[indexPath.row].id
                self.carsArray.remove(at: indexPath.row)
                guard let car = realm.objects(Car.self).first(where: {$0.id == id}) else { return }
                realm.delete(car)
                self.tableView.reloadData()
            }
        }
    }
    
}
