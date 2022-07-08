//
//  MiniSteamingAppUITests.swift
//  MiniSteamingAppUITests
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import XCTest

class MiniSteamingAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    func testEventsScreenExists() {
        XCTAssertTrue(app.navigationBars["Events"].exists)
    }
    
    func testPlayAssetFlow() {
        app.otherElements["videoCard"].firstMatch.wait(until: \.exists).tap()
        XCTAssertTrue(app.otherElements["playerView"].exists)
        XCTAssertTrue(app.navigationBars["Schedule"].exists)
    }
    
    func testCloseButtonDissmissesPlayerView() {
        app.otherElements["videoCard"].firstMatch.wait(until: \.exists).tap()
        app.buttons["close"].wait(until: \.exists).tap()
        XCTAssertFalse(app.navigationBars["Events"].wait(until: \.exists).exists)
    }

}
