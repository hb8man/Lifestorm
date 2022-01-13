//
//  Date Formatter.swift
//  LifeStorm
//
//  Created by William Bateman on 10/8/21.
//

import Foundation

extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
    
}
