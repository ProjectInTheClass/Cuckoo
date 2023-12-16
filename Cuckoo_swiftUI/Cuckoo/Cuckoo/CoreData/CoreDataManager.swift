//
//  CoreDataManager.swift
//  Cuckoo
//
//  Created by DKSU on 12/16/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "CoreDataContainer")
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    print("ERROR LOADING CORE DATA. \(error)")
                } else {
                    print("SUCCESSFULLY LOADED CORE DATA. \(description)")
                }
            }
            return container
    }()
    
    var context: NSManagedObjectContext {
            return persistentContainer.viewContext
    }
    
    var MemoEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "MemoEntity", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
