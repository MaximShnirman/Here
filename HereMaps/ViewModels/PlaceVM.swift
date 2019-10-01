//
//  PlaceVM.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import CoreGraphics

struct PlaceVM {
    var title: String
    var vicinity: String
    var href: String
    var id: String
}

extension PlaceVM {
    init(place: PlacesModel.Item) {
        self.title = place.title
        self.vicinity = place.vicinity
        self.href = place.href
        self.id = place.id
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
