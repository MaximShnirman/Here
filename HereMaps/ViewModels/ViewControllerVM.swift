//
//  ViewControllerVM.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 01/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import CoreGraphics

struct ViewControllerVM {
    
    var viewModel = Observable<CellsVM>(CellsVM())

    func start() {
        loadPlaces { (placesVM) in
            guard let places = placesVM else { return }
            self.viewModel.value = places
        }
    }
    
    func cellIdentifier(for viewModel: RowCellViewModel) -> String {
        switch viewModel {
        case is CellsVM:
            return TableViewCell.Identifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    private func loadPlaces(completion: @escaping ((CellsVM?) -> ())) {
        NetworkManager().getPlaces(location: CGPoint(x: 19.4333, y: -99.1333)) { (result, error) in
            if let error = error {
                // TODO: add error handing
                print(error)
                completion(nil)
            } else {
                guard let result = result else { return }
                let places = result.results.items.compactMap { item in
                    return CellVM(place: item)
                }
                let placesVm = CellsVM(places: places)
                completion(placesVm)
            }
        }
    }
}
