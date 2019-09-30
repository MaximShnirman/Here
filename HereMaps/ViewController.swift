//
//  ViewController.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    var dynamicStr = Dynamic<String>("initialized")
//    @IBOutlet weak var label: UILabel!
//
//    @IBOutlet weak var textField: BindingTextField! {
//        didSet {
//            textField.bind { [unowned self] in self.dynamicStr.value = $0 }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        dynamicStr.bind = { [unowned self] in self.label.text = $0 }
//    }
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager: NetworkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getReverseGeocode(location: CGPoint(x: 19.4333, y: -99.1333)) { (mapObj, error) in
            if let error = error {
                print(error)
            } else {
                print(mapObj!)
            }
        }
        
        networkManager.getPlaces(location: CGPoint(x: 19.4333, y: -99.1333)) { (places, error) in
            if let error = error {
                print(error)
            } else {
                print(places!)
            }
        }
    }
}

