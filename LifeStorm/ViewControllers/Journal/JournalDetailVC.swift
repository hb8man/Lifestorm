//
//  JournalDetailVC.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import UIKit

class JournalDetailVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var journalRectangle: UIView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var dateRect: UIView!
    // MARK: Properties
    var entry: Entry?
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UISwipeGestureRecognizer(target: self.bodyTextView, action: #selector(bodyTextView.endEditing(_:)))
        tap.direction = .down
        bodyTextView.addGestureRecognizer(tap)
        updateViews()
        journalRectangle.layer.cornerRadius = 12
        journalRectangle.layer.opacity = 0.30
        titleTextField.layer.cornerRadius = 12
        
        dateRect.layer.opacity = 0.30
        dateRect.layer.cornerRadius = 6
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else { return }
        
        
        if let entry = entry {
            JournalController.shared.updateEntry(entry: entry, newTitle: title, newBody: body)
        } else {
            JournalController.shared.createNewEntry(title: title, body: body)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: Helper Methods
    func updateViews() {
        if let entry = entry {
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
            timestampLabel.text = entry.timestamp?.dateAsString()
        }
    }

} // End of Class
