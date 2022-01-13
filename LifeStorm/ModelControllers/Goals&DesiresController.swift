//
//  Goals&DesiresController.swift
//  LifeStorm
//
//  Created by William Bateman on 10/9/21.
//

import Foundation
import CoreData

class GoalsAndDesiresController {
    
    static let shared = GoalsAndDesiresController()
    
    var goals: [Goal] = []
    var desires: [Desire] = []
    
    private lazy var goalFetchRequest: NSFetchRequest<Goal> = {
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private lazy var desireFetchRequest: NSFetchRequest<Desire> = {
        let request = NSFetchRequest<Desire>(entityName: "Desire")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: CRUD Functions
    
    // Create
    
    func createNewGoal(name: String, notes: String) {
        let newGoal = Goal(name: name, notes: notes, context: coreDataStack.context)
        goals.append(newGoal)
        coreDataStack.saveContext()
    }
    
    func createNewDesire(name: String, notes: String) {
        let newDesire = Desire(name: name, notes: notes, context: coreDataStack.context)
        desires.append(newDesire)
        coreDataStack.saveContext()
    }
    
    // Read
    func fetchGoals() {
        let goalsToFetch = ( try?
            coreDataStack.context.fetch(goalFetchRequest)) ?? []
        self.goals = goalsToFetch
    }
    
    func fetchDesires() {
        let desiresToFetch = ( try?
            coreDataStack.context.fetch(desireFetchRequest)) ?? []
        self.desires = desiresToFetch
    }
    
    // Update
    func updateGoal(goal: Goal, newName: String, newNotes: String) {
        goal.name = newName
        goal.notes = newNotes
        coreDataStack.saveContext()
    }
    
    func updateDesire(desire: Desire, newName: String, newNotes: String) {
        desire.name = newName
        desire.notes = newNotes
        coreDataStack.saveContext()
    }
    
    // Delete
    func deleteGoal(goal: Goal) {
        guard let index = goals.firstIndex(of: goal) else { return }
        goals.remove(at: index)
        coreDataStack.saveContext()
    }
    
    func deleteDesire(desire: Desire) {
        guard let index = desires.firstIndex(of: desire) else { return }
        desires.remove(at: index)
        coreDataStack.saveContext()
    }
    
    
    
} // End of Class

