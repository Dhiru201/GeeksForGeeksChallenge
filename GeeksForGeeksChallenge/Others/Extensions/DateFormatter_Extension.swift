//
//  DateFormatter_Extension.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let readableDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
}

extension Date {
    //
    func formattedEndDate() -> String? {
        return "\(DateFormatter.readableDateFormatter.string(from: self))"
    }
    
}


