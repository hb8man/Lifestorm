//
//  GoalCell.swift
//  LifeStorm
//
//  Created by William Bateman on 10/9/21.
//

import UIKit

class GoalCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var rectangle: UIView!
    
    @IBOutlet weak var timestampRect: UIView!
    
    
    // MARK: Properties
    var goal: Goal? {
        didSet {
            guard let goal = goal else { return }
            updateGoalViews()
        }
    }
    
    var desire: Desire? {
        didSet {
            guard let desire = desire else { return }
            updateDesireViews()
        }
    }
    
    
    // MARK: Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()

        rectangle.layer.opacity = 0.25
        rectangle.layer.cornerRadius = 25
        
        timestampRect.layer.opacity = 0.30
        timestampRect.layer.cornerRadius = 6.0
        
    }

    
    // MARK: Helper Functions
    func updateGoalViews() {
        guard let goal = goal else { return }
        nameLabel.text = goal.name
        timestampLabel.text = goal.timeStamp?.dateAsString()
        notesLabel.text = goal.notes
    }
    
    func updateDesireViews() {
        guard let desire = desire else { return }
        nameLabel.text = desire.name
        timestampLabel.text = desire.timeStamp?.dateAsString()
        notesLabel.text = desire.notes
    }

}
