//
//  Utils.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import Foundation

class Utils {
    static func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return  dateFormatter.string(from: date!)
    }
    
    static func correctDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return  dateFormatter.string(from: date!)
    }
    
    static func prepareForPrint (_ text:String) -> String {
        let x = text.components(separatedBy: "...")[0]
        let y = x.replacingOccurrences(of: "\\<.*\\>", with: "", options: .regularExpression)
        let z = y.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression)
        return z + "..."
    }
    
    static func convertStringToDate (_ strDate:String) -> Date {
        let newData = convertDateFormater(strDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dt = dateFormatter.date(from: newData)
        
        return dt!
    }
    
    static func getHostName (channel:String)->String? {
        let url = URL(string: channel)
        return url?.host
        
        
    }
}
