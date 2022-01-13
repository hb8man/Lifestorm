//
//  Entry+Convenience.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import Foundation
import CoreData

extension Entry {
    @discardableResult
    convenience init(title: String, body: String, timestamp: Date = Date(), context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}


