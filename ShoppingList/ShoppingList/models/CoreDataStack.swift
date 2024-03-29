//
//  CoreDataStack.swift
//  ShoppingList
//
//  Created by Matthew O'Connor on 9/27/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList")//update
        // _ means dont care
        container.loadPersistentStores(completionHandler: {(_, error) in
            if let error = error {
                fatalError("Failed to load Persistent Store \(error)")
                
            }
        })
        return container
    } ()
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
