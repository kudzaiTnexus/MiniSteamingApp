//
//  Date+Extension.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 06/07/2022.
//

import Foundation

extension Date {
    
    private var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    private var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    private var daysFromToday: Int? {
        Calendar.current.numberOfDaysBetween(Date(), and: self)
    }
    
    public var epgStartDate: String {
            if self.isYesterday {
                return "\(L10n.yesterday), \(self.format("HH:mm"))"
            } else if self.isToday {
                return "\(L10n.today), \(self.format("HH:mm"))"
            } else if self.isTomorrow {
                return "\(L10n.tommorow), \(self.format("HH:mm"))"
            } else if let daysFromToday = daysFromToday,
                      (2...5).contains(daysFromToday) {
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .spellOut
                
                if let spellOutText = formatter.string(for: daysFromToday) {
                    return "\(L10n.inDayTime(spellOutText))"
                } else {
                    return ""
                }
            } else {
                return self.format("dd/MM/yyyy")
            }
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

