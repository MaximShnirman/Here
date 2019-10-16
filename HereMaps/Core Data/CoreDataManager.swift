//
//  CoreDataManager.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 16/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static public let shared = CoreDataManager()
    static private let containerName: String = "HereMaps"
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print(storeDescription)
            }
        })
        return container
    }()
}

extension CoreDataManager {
    
    func saveMainContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllPlaces() -> [Place]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        
        do {
            let places = try context.fetch(fetchRequest)
            return places as? [Place]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func insertPlace(vm: CellVM) -> Place? {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: context)!
        let place = NSManagedObject(entity: entity, insertInto: context)
        
        place.setValue(vm.title, forKeyPath: "title")
        place.setValue(vm.vicinity, forKeyPath: "vicinity")
        place.setValue(vm.href, forKeyPath: "href")
        place.setValue(vm.id, forKeyPath: "id")
        
        do {
            try context.save()
            return place as? Place
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func update(vm: CellVM, place : Place) {
        let context = persistentContainer.viewContext
        do {
            place.setValue(vm.title, forKeyPath: "title")
            place.setValue(vm.vicinity, forKeyPath: "vicinity")
            place.setValue(vm.href, forKeyPath: "href")
            place.setValue(vm.id, forKeyPath: "id")
            
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        }
    }
    
    func delete(id: String) -> [Place]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let placesForId = try context.fetch(fetchRequest)
            var arrRemovedPlaces = [Place]()
            
            for place in placesForId {
                context.delete(place)
                try context.save()
                arrRemovedPlaces.append(place as! Place)
            }
            return arrRemovedPlaces
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
}
