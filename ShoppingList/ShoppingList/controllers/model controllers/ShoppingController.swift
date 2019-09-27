//
//  ShoppingController.swift
//  ShoppingList
//
//  Created by Matthew O'Connor on 9/27/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import CoreData

class ShoppingController {
    static let shared = ShoppingController()
    
    let fetchResultsController: NSFetchedResultsController<Shopping>
    init () {
        let request: NSFetchRequest<Shopping> = Shopping.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: false)
        request.sortDescriptors = [isCompleteSort]
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    //crud
    //create
    func create(name: String, isComplete: Bool) {
        let newItem = Shopping(name: name, isComplete: isComplete)
        saveToPersistentStorage()
    }

    //update
    func update(shopping: Shopping, name: String, isComplete: Bool) {
        shopping.name = name
        shopping.isComplete = isComplete
        saveToPersistentStorage()
    }
    
    //delete
    func delete(shopping: Shopping) {
        shopping.managedObjectContext?.delete(shopping)
        saveToPersistentStorage()
    }
    
    //toggle
    func toggle(shopping: Shopping){
        shopping.isComplete.toggle()
        saveToPersistentStorage()
    }
    
    //Save
    func saveToPersistentStorage () {
        if CoreDataStack.context.hasChanges {
            try? CoreDataStack.context.save()
        }
    }
} //end of section
