//
//  JournalController.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import Foundation
import CoreData
import CloudKit

class JournalController {

    static let shared = JournalController()
    
    var entries: [Entry] = []
    
    let container = CKContainer.default().privateCloudDatabase
    
    private lazy var fetchRequest: NSFetchRequest<Entry> = {
        let request = NSFetchRequest<Entry>(entityName: "Entry")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: CRUD Functions
    
    // Create
    func createNewEntry(title: String, body: String) {
        let newEntry = Entry(title: title, body: body, context: coreDataStack.context)
        entries.insert(newEntry, at: 0)
        coreDataStack.saveContext()
    }
    
    // Read
    func fetchEntries() {
        let entriesToFetch = ( try?
            coreDataStack.context.fetch(fetchRequest)) ?? []
        self.entries = entriesToFetch.reversed()
        
    }
    
    // Update
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        coreDataStack.saveContext()
    }
    
    // Delete
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        coreDataStack.saveContext()
    }
    
    
} // End of Class

