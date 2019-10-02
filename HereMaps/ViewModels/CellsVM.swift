//
//  CellVM.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import CoreGraphics

struct CellVM {
    var title: String
    var vicinity: String
    var href: String
    var id: String
}

extension CellVM: RowCellViewModel {
    init(place: PlacesModel.Item) {
        self.title = place.title
        self.vicinity = place.vicinity
        self.href = place.href
        self.id = place.id
    }
}

struct CellsVM {
    var title: String? = "Places"
    var cellHeight: CGFloat = 128.0
    var places: [CellVM] = [CellVM]()
}

extension CellsVM {
    init(places: [CellVM]) {
        self.places = places
    }
}
