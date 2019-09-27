//
//  Shopping+Convenience.swift
//  ShoppingList
//
//  Created by Matthew O'Connor on 9/27/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import CoreData

extension Shopping {
    convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.isComplete = isComplete
    }
}
