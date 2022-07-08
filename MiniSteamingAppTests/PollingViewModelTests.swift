//
//  PollingViewModelTests.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 08/07/2022.
//

@testable import MiniSteamingApp
import Foundation
import Combine
import XCTest

class PollingViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testPolling() {
        
        let sut = PollingViewModel(interval: 1)

        let expectation = XCTestExpectation(description: #function)
        let expectedTimeIntervals = [1.0, 2.0, 3.0]
        var receivedTimeIntervals: [TimeInterval] = []
        
        sut.beginPolling()
        let startTimeInterval = Date.timeIntervalSinceReferenceDate
        
        sut.timer
            .prefix(3)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTAssertEqual(receivedTimeIntervals, expectedTimeIntervals)
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                    }
                },
                receiveValue: { date in
                    let interval = (date.timeIntervalSinceReferenceDate - startTimeInterval)
                    receivedTimeIntervals.append(floor(interval.normalized))
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 3.0)
    }
}

fileprivate extension TimeInterval {
    var normalized: TimeInterval {
        (self * 10).rounded() / 10
    }
}
