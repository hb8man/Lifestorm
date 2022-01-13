//
//  Reminders&EventsVC.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import UIKit

import EventKit
import EventKitUI
import UIKit

class Reminders_EventsVC: UIViewController, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var remindersSegmentBar: UISegmentedControl!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var reminderEventTableView: UITableView!
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = store.defaultCalendarForNewReminders()
        remindersSegmentBar.selectedSegmentIndex = 0
        store.requestAccess(to: .reminder) { success, error in
            if success, error == nil {
                self.calendar = self.store.defaultCalendarForNewReminders()
            } else {
                return
            }
        }
        fetchEvents()
        fetchReminders()
        setUpViews()
        reminderEventTableView.reloadData()
        reminderEventTableView.reloadData()
        
        addButton.target = self
        addButton.action = #selector(didTapAdd)
        


        reminderEventTableView.separatorStyle = .none

        reminderEventTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reminderEventTableView.reloadData()
    }
    
    
    // MARK: Properties
    let store = EKEventStore()
    var events: [EKEvent] = []
    var reminders: [EKReminder] = []
    var calendar: EKCalendar?
    
    // MARK: Actions

    @objc func didTapAdd() {
        store.requestAccess(to: .event) { success, error in
            if success, error == nil {
                
            } else {
                return
            }
        }
        if remindersSegmentBar.selectedSegmentIndex == 0 {
            let alert = UIAlertController(title: "New Reminder", message: "Create New Reminder", preferredStyle: .alert)

            alert.addTextField { textfield in
                textfield.placeholder = "Title"
            }
            alert.addTextField { textfield in
                textfield.placeholder = "Notes"
            }


            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                guard let title = alert.textFields?.first?.text, !title.isEmpty, let notes = alert.textFields?[1].text, !notes.isEmpty else { return }
                let newReminder = EKReminder(eventStore: self.store)
                newReminder.title = title
                newReminder.notes = alert.textFields?[1].text
                newReminder.calendar = self.calendar

                do {
                    try self.store.save(newReminder, commit: true)
                    self.reminderEventTableView.reloadData()
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                self.reminders.append(newReminder)
                self.reminderEventTableView.reloadData()
            }))
            present(alert, animated: true, completion: nil)
            reminderEventTableView.reloadData()



            
        } else if remindersSegmentBar.selectedSegmentIndex == 1 {
            let newEvent = EKEvent(eventStore: store)
            newEvent.title = "New Calendar Event"
            newEvent.startDate = Date()
            newEvent.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
            newEvent.alarms = [EKAlarm(absoluteDate: newEvent.startDate)]
            
            let vc = EKEventEditViewController()
            vc.editViewDelegate = self
            vc.eventStore = store
            vc.event = newEvent
            
            present(vc, animated: true)
            
        } else {
            
        }
    }
    
    @IBAction func segmentBarPressed(_ sender: Any) {
        reminderEventTableView.reloadData()
        if remindersSegmentBar.selectedSegmentIndex == 0 {
        } else if remindersSegmentBar.selectedSegmentIndex == 1 {
        }
    }
    
    // MARK: Helper Functions
    func setUpViews() {
        reminderEventTableView.delegate = self
        reminderEventTableView.dataSource = self
    }
    
    func fetchEvents() {
        let calendar = Calendar.current
        var oneDayAgoComponents = DateComponents()
        oneDayAgoComponents.day = -1
        let oneDayAgo = calendar.date(byAdding: oneDayAgoComponents, to: Date(), wrappingComponents: false)
        
        var oneYearFromNowComponents = DateComponents()
        oneYearFromNowComponents.year = 1
        let oneYearFromNow = calendar.date(byAdding: oneYearFromNowComponents, to: Date(), wrappingComponents: false)
        
        var predicate: NSPredicate? = nil
        if let dayAgo = oneDayAgo, let yearAgo = oneYearFromNow {
            predicate = store.predicateForEvents(withStart: dayAgo, end: yearAgo, calendars: nil)
        }
        if let PREDICATE = predicate {
            events = store.events(matching: PREDICATE)
        }
    }
    
    func fetchReminders() {
        let CALENDAR = Calendar.current
        var weekAgoComponents = DateComponents()
        weekAgoComponents.day = -7
        var weekAgo = CALENDAR.date(byAdding: weekAgoComponents, to: Date())
        var yearFromNowComponents = DateComponents()
        yearFromNowComponents.year = 1
        var yearFromNow = CALENDAR.date(byAdding: yearFromNowComponents, to: Date())
        
        guard let calendar = calendar else { return }
        let predicate: NSPredicate? = store.predicateForIncompleteReminders(withDueDateStarting: nil, ending: nil, calendars: [calendar])
        if let aPredicate = predicate {
            store.fetchReminders(matching: aPredicate, completion: {(_ reminders: [Any]?) -> Void in
                for reminder: EKReminder? in reminders as? [EKReminder?] ?? [EKReminder?]() {
                    if let reminder = reminder {
                        
                        self.reminders.append(reminder)
                    }
                }
            })
        }
        reminderEventTableView.reloadData()
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateReminderVC" {
            guard let indexPath = reminderEventTableView.indexPathForSelectedRow, let destination = segue.destination as? ReminderVC else { return }
            
            let reminder = reminders[indexPath.row]
            destination.reminder = reminder
        }
    }

} // End of Class


extension Reminders_EventsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if remindersSegmentBar.selectedSegmentIndex == 0 {
            return reminders.count
        } else if remindersSegmentBar.selectedSegmentIndex == 1 {
            return events.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? ReminderCell else { return UITableViewCell() }
        
        if remindersSegmentBar.selectedSegmentIndex == 0 {
            let reminder = reminders[indexPath.row]
            cell.reminder = reminder
            return cell
            
        } else if remindersSegmentBar.selectedSegmentIndex == 1 {
            let event = events[indexPath.row]
            cell.event = event
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if remindersSegmentBar.selectedSegmentIndex == 0 {
                let reminder = reminders[indexPath.row]
                guard let index = reminders.firstIndex(of: reminder) else { return }
                reminders.remove(at: index)
                do {
                    try store.remove(reminder, commit: true)
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } else if remindersSegmentBar.selectedSegmentIndex == 1 {
                let event = events[indexPath.row]
                guard let index = events.firstIndex(of: event) else { return }
                events.remove(at: index)
                    do {
                        try store.remove(event, span: .thisEvent)
                    } catch {
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension Reminders_EventsVC: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension Reminders_EventsVC: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        
        guard let event = controller.event else { return }
        
        switch action {
        
        case .canceled:
            self.dismiss(animated: true, completion: nil)
        case .saved:
            do {
                try store.save(event, span: .thisEvent)
                fetchEvents()
                reminderEventTableView.reloadData()
                print(events)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            self.dismiss(animated: true, completion: nil)
        case .deleted:
            self.dismiss(animated: true, completion: nil)
        @unknown default:
            print("Unknown Default?")
        }
    }
}

