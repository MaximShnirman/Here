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
    private var viewModel: Observable<CellsVM>? {
        return controllerVM.viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.valueChanged = { [weak self] (_) in
            DispatchQueue.main.async {
                self?.title = self?.viewModel?.value.title
                self?.tableView.reloadData()
            }
        }
        controllerVM.start()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.value.cellHeight ?? 0
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.value.places.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else {
            print("no view model found. initializing UITableViewCell")
            return UITableViewCell()
        }
        let cvm = vm.value.places[indexPath.row] as RowCellViewModel
        guard let cell = tableView.dequeueReusableCell(withIdentifier: controllerVM.cellIdentifier(for: cvm)) else {
            print("couldn't dequeue cell for \(cvm)")
            return UITableViewCell()
        }
        
        if let cell = cell as? ConfigurableCell {
            cell.setupCell(viewModel: cvm)
        } else {
            print("cell is not ConfigurableCell?")
        }
        
        return cell
    }
}

