//
//  ReminderCell.swift
//  LifeStorm
//
//  Created by William Bateman on 10/10/21.
//

import UIKit
import EventKit

class ReminderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reminderRectangle: UIView!
    
    var event: EKEvent? {
        didSet {
            updateEventViews()
        }
    }
    var reminder: EKReminder? {
        didSet {
            updateReminderViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reminderRectangle.layer.opacity = 0.25
        reminderRectangle.layer.cornerRadius = 25
        
    }

    // MARK: Helper Methods
    
    func updateEventViews() {
        titleLabel.text = event?.title
        dateLabel.text = event?.startDate.dateAsString()
    }
    
    func updateReminderViews() {
        titleLabel.text = reminder?.title
        dateLabel.text = reminder?.completionDate?.dateAsString()
    }

}
