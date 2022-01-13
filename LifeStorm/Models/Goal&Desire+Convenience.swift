//
//  Goal&Desire+Convenience.swift
//  LifeStorm
//
//  Created by William Bateman on 10/9/21.
//

import Foundation
import CoreData

extension Goal {
    @discardableResult
    convenience init(name: String, notes: String, timestamp: Date = Date(), context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.timeStamp = timestamp
    }
}

extension Desire {
    @discardableResult
    convenience init(name: String, notes: String, timestamp: Date = Date(), context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.timeStamp = timestamp
    }
}
