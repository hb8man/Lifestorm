//
//  JournalCell.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import UIKit

class EntryCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryTimestampLabel: UILabel!
    @IBOutlet weak var cellRectangle: UIView!
    
    @IBOutlet weak var dateRectangle: UIView!
    // MARK: Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        cellRectangle.layer.opacity = 0.25
        cellRectangle.layer.cornerRadius = 25
        
        dateRectangle.layer.opacity = 0.30
        dateRectangle.layer.cornerRadius = 6
    }

    // MARK: Helper Methods
    func updateViews() {
        guard let entry = entry else { return }
        entryTitleLabel.text = entry.title
        entryTimestampLabel.text = entry.timestamp?.dateAsString()
    }

} // End of Class

