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
    
    private lazy var persistentContainer: NSPersistentContainer = {
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
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func saveContext(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func saveMainContext() {
        saveContext(context: viewContext)
    }
}
