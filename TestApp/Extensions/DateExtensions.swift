//
//  DateExtensions.swift
//  TestApp
//
//  Created by Вячеслав on 6/5/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import Foundation

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let day = interval.day, day > 0  {
            return "Other"
        }
            
        else if let hour = interval.hour, hour > 15 {
            return "Yesterday"
        }
            
        else if let minutes = interval.minute, minutes > 1 {
            return "Today"
        }
        else {
            return "Just receintly"
        }
        
    }
}
