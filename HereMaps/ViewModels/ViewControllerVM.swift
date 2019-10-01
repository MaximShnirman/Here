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
    
    var viewModel = Observable<PlacesVM>(PlacesVM())

    func start() {
        loadPlaces { (placesVM) in
            guard let places = placesVM else { return }
            self.viewModel.value = places
        }
    }

    private func loadPlaces(completion: @escaping ((PlacesVM?) -> ())) {
        NetworkManager().getPlaces(location: CGPoint(x: 19.4333, y: -99.1333)) { (result, error) in
            if let error = error {
                // TODO: add error handing
                print(error)
                completion(nil)
            } else {
                guard let result = result else { return }
                let places = result.results.items.compactMap { item in
                    return PlaceVM(place: item)
                }
                let placesVm = PlacesVM(places: places)
                completion(placesVm)
            }
        }
    }
}
