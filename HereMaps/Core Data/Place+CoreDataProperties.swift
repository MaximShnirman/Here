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
    
    enum PlaceErrors: Error {
        case runtimeError(String)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var title: String?
    @NSManaged public var vicinity: String?
    @NSManaged public var href: String?
    @NSManaged public var id: String?
}

extension Place {
    
    // TODO: should go with throws or return types here?
    class func fetchPlaces(moc: NSManagedObjectContext) -> [Place]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        
        do {
            let places = try moc.fetch(fetchRequest)
            return places as? [Place]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    @discardableResult
    class func insertPlace(moc: NSManagedObjectContext, vm: CellVM) throws -> Place? {
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: moc)!
        let place = NSManagedObject(entity: entity, insertInto: moc)
        
        place.setValue(vm.title, forKeyPath: "title")
        place.setValue(vm.vicinity, forKeyPath: "vicinity")
        place.setValue(vm.href, forKeyPath: "href")
        place.setValue(vm.id, forKeyPath: "id")
        
        do {
            try moc.save()
            return place as? Place
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            throw PlaceErrors.runtimeError("couldnt save, check logs")
        }
    }
    
    class func update(moc: NSManagedObjectContext, vm: CellVM, place : Place) throws {
        do {
            place.setValue(vm.title, forKeyPath: "title")
            place.setValue(vm.vicinity, forKeyPath: "vicinity")
            place.setValue(vm.href, forKeyPath: "href")
            place.setValue(vm.id, forKeyPath: "id")
            
            do {
                try moc.save()
                print("saved!")
            } catch {
                print(error)
                throw PlaceErrors.runtimeError("some error while updating")
            }
        }
    }
    
    @discardableResult
    class func delete(moc: NSManagedObjectContext, id: String) -> [Place]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let placesForId = try moc.fetch(fetchRequest)
            var arrRemovedPlaces = [Place]()
            
            for place in placesForId {
                moc.delete(place)
                try moc.save()
                arrRemovedPlaces.append(place as! Place)
            }
            return arrRemovedPlaces
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    class func fetchPlace(for id: String, moc: NSManagedObjectContext) -> Place? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let placesForId = try moc.fetch(fetchRequest)
            if placesForId.count > 1 {
                print("found more then 1 object for id: %@", id)
            }
            return placesForId.first as? Place
        } catch let error {
            print(error)
            return nil
        }
    }
}
