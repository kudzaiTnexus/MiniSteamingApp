//
//  Calendar+Extension.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 06/07/2022.
//

import Foundation

extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}
