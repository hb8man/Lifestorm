//
//  Goals&DesiresVC.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import UIKit

class GoalsTabVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var coolTableView: UITableView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    

    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalsAndDesiresController.shared.fetchGoals()
        GoalsAndDesiresController.shared.fetchDesires()
        coolTableView.delegate = self
        coolTableView.dataSource = self
        segmentBar.selectedSegmentIndex = 0
        coolTableView.separatorStyle = .none
        
        // Set segment index to default 0
    }
    
    // MARK: Actions
    @IBAction func segmentBarPressed(_ sender: Any) {
        coolTableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if segmentBar.selectedSegmentIndex == 0  {
            let alert = UIAlertController(title: "New Goal", message: "Set a new goal!", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "Goal Name"
            }
            
            alert.addTextField { textField in
                textField.placeholder = "Description"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { _ in
                guard let name = alert.textFields?.first?.text, let description = alert.textFields?[1].text, !name.isEmpty, !description.isEmpty else { return }
                
                GoalsAndDesiresController.shared.createNewGoal(name: name, notes: description)
                self.coolTableView.reloadData()
            }))
            present(alert, animated: true)
        
        } else if segmentBar.selectedSegmentIndex == 1 {
            let alert = UIAlertController(title: "New Desire", message: "What do you desire?", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "Desire Name"
            }
            
            alert.addTextField { textField in
                textField.placeholder = "Description"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { _ in
                guard let name = alert.textFields?.first?.text, let description = alert.textFields?[1].text, !name.isEmpty, !description.isEmpty else { return }
                
                GoalsAndDesiresController.shared.createNewDesire(name: name, notes: description)
                self.coolTableView.reloadData()
            }))
            present(alert, animated: true)
            
            
        }
//        print("G: \(GoalController.shared.goals.count), D: \(DesireController.shared.desires.count)")
        
    }
    // MARK: Helper Functions


} // End of Class


extension GoalsTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentBar.selectedSegmentIndex == 0 {
            return GoalsAndDesiresController.shared.goals.count
        } else if segmentBar.selectedSegmentIndex == 1 {
            return GoalsAndDesiresController.shared.desires.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else { return UITableViewCell() }

        if segmentBar.selectedSegmentIndex == 0 {
            let goal = GoalsAndDesiresController.shared.goals[indexPath.row]
            cell.goal = goal
            return cell

        } else if segmentBar.selectedSegmentIndex == 1 {
            let desire = GoalsAndDesiresController.shared.desires[indexPath.row]
            cell.desire = desire
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        111
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if segmentBar.selectedSegmentIndex == 0 {
                let goalToDelete = GoalsAndDesiresController.shared.goals[indexPath.row]
                GoalsAndDesiresController.shared.deleteGoal(goal: goalToDelete)
                tableView.deleteRows(at: [indexPath], with: .fade)

            } else if segmentBar.selectedSegmentIndex == 1 {
                let desireToDelete = GoalsAndDesiresController.shared.desires[indexPath.row]
                GoalsAndDesiresController.shared.deleteDesire(desire: desireToDelete)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

