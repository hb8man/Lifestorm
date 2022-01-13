//
//  JournalTableVC.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import UIKit

class JournalListTableVC: UITableViewController {

    // MARK: Properties
    var entry: Entry?
    
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        JournalController.shared.fetchEntries()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JournalController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as? EntryCell else { return UITableViewCell() }
    
        let entry = JournalController.shared.entries[indexPath.row]
        
        cell.entry = entry
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = JournalController.shared.entries[indexPath.row]
            JournalController.shared.deleteEntry(entry: entry)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? JournalDetailVC else { return }
        
        let entry = JournalController.shared.entries[indexPath.row]
        destination.entry = entry
    }
    
} // End of Class
