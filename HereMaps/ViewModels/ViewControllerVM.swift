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
    
    typealias handler = ((CellsVM?) -> ())
    
    var viewModel = Observable<CellsVM>(CellsVM())
    private let cache = Cache<String, CellsVM>()

    func start() {
        loadPlaces { (placesVM) in
            guard let places = placesVM else {
                print("failed unwrapping placesVM")
                return
            }
            self.viewModel.value = places
        }
    }
    
    func cellIdentifier(for viewModel: RowCellViewModel) -> String {
        switch viewModel {
        case is CellVM:
            return TableViewCell.Identifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    private func loadPlaces(at point: CGPoint = CGPoint(x: 19.4333, y: -99.1333), completion: @escaping handler) {
        let pointStr = NSCoder.string(for: point)
        if let cached = cache[pointStr] {
            completion(cached)
        }
        
        NetworkManager().getPlaces(location: point) { (result, error) in
            if let error = error {
                // TODO: add error handing
                print(error)
                completion(nil)
            } else {
                guard let result = result else {
                    print("failed unwrapping result")
                    return
                }
                let places = result.results.items.compactMap { item in
                    return CellVM(place: item)
                }
                let placesVm = CellsVM(places: places)
                self.cache[pointStr] = placesVm
                completion(placesVm)
            }
        }
    }
}
