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
        XCTAssertTrue(app.navigationBars["Events"].wait(until: \.exists).exists)
    }
    
    func testPlayAssetFlow() {
        app.otherElements["videoCard"].firstMatch.wait(until: \.exists).tap()
        XCTAssertTrue(app.otherElements["playerView"].exists)
    }
    
    // TODO: Still needs to be fixed as this is not a full proof solution
    // need to figure out why this doesnt work
    // XCTAssertFalse(app.navigationBars.otherElements["Events"].wait(until: \.exists).exists)
    func testCloseButtonDissmissesPlayerView() {
        app.otherElements["videoCard"].firstMatch.wait(until: \.exists).tap()
        app.buttons["close"].wait(until: \.exists).tap()
        XCTAssertTrue(app.otherElements["videoCard"].wait(until: \.exists).exists)
    }

}
