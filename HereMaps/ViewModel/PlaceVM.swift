//
//  PlaceVM.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

struct PlaceVM {
    var location: String
    var address: String
}

extension PlaceVM {
    init(place: PlacesModel.Item) {
        self.location = place.icon
        self.address = place.id
    }
}

struct PlacesVM {
    var title: String? = "Places"
    var places: [PlaceVM] = [PlaceVM]()
}

extension PlacesVM {
    init(places: [PlaceVM]) {
        self.places = places
    }
}
