//
//  Place+CoreDataProperties.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 13/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var title: String?
    @NSManaged public var vicinity: String?
    @NSManaged public var href: String?
    @NSManaged public var id: String?

}
