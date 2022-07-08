//
//  Dates.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 06/07/2022.
//

import Foundation

public extension DateFormatter {
    
    static var daznDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }
    
    static func date(fromDAZNString string: String) -> Date? {
        return daznDateFormatter.date(from: string)
    }

}
