//
//  ReminderVC.swift
//  LifeStorm
//
//  Created by William Bateman on 10/11/21.
//

import UIKit
import EventKit

class ReminderVC: UIViewController {

    
    // MARK: Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var dateRect: UIView!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    // MARK: Properties
    var reminder: EKReminder? {
        didSet {
            
        }
    }
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dateRect.layer.opacity = 0.30
        dateRect.layer.cornerRadius = 12

    }
    
    
    // MARK: Helper Methods
    func updateViews() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
