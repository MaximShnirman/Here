//
//  ViewController.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let controllerVM = ViewControllerVM()
    private var viewModel: Observable<PlacesVM>? {
        return controllerVM.viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.valueChanged = { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.title = self?.viewModel?.value.title
            }
        }
        controllerVM.start()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.value.places.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.Identifier) as? TableViewCell else { return UITableViewCell() }
        cell.setCell(with: (viewModel?.value.places[indexPath.row])!)
        return cell
    }
}

