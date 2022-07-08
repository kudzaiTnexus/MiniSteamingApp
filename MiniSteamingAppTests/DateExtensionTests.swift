//
//  DateExtensionTests.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 07/07/2022.
//

import XCTest
@testable import MiniSteamingApp

class DateExtensionTests: XCTestCase {

    func testEpgStartDtaeReturnsCorrectLocalisation() {
        let today = Date()
        let twoDaysAgoFromNow = Calendar.current.date(byAdding: .day, value: -2, to: today)
        let oneDayAgoFromNow = Calendar.current.date(byAdding: .day, value: -1, to: today)
        let oneDayFromNow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: today)
        let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: today)
        let fourDaysFromNow = Calendar.current.date(byAdding: .day, value: 4, to: today)
        let fiveDaysFromNow = Calendar.current.date(byAdding: .day, value: 5, to: today)
        let sixDaysFromNow = Calendar.current.date(byAdding: .day, value: 6, to: today)
        let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: today)

        XCTAssertEqual(twoDaysAgoFromNow?.epgStartDate, twoDaysAgoFromNow?.format("dd/MM/yyyy"))
        XCTAssertEqual(oneDayAgoFromNow?.epgStartDate, "Yesterday, \(oneDayAgoFromNow!.format("HH:mm"))")
        XCTAssertEqual(oneDayFromNow?.epgStartDate, "Tommorow, \(oneDayAgoFromNow!.format("HH:mm"))")
        XCTAssertEqual(today.epgStartDate, "Today, \(today.format("HH:mm"))")
        XCTAssertEqual(twoDaysFromNow?.epgStartDate, "In two days")
        XCTAssertEqual(threeDaysFromNow?.epgStartDate, "In three days")
        XCTAssertEqual(fourDaysFromNow?.epgStartDate, "In four days")
        XCTAssertEqual(fiveDaysFromNow?.epgStartDate, "In five days")
        XCTAssertEqual(sixDaysFromNow?.epgStartDate, sixDaysFromNow?.format("dd/MM/yyyy"))
        XCTAssertEqual(sevenDaysFromNow?.epgStartDate, sevenDaysFromNow?.format("dd/MM/yyyy"))
    }

}
