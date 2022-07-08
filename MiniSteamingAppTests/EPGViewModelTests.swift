//
//  EPGViewModelTests.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 08/07/2022.
//

@testable import MiniSteamingApp
import Foundation
import Combine
import XCTest

class EPGViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    var sut: EPGViewModel!
    var stubEPGService: StubEPGService!
    
    @MainActor override func setUp() {
        super.setUp()
        stubEPGService = StubEPGService()
        sut = EPGViewModel(service: stubEPGService)
    }
    
    // MARK: Check on init VM is setup correctly
    
    @MainActor func testOnInitEmptyEvents() {
        XCTAssertTrue(sut.events.isEmpty)
    }
    
    @MainActor func testOnInitEmptySchedule() {
        XCTAssertTrue(sut.schedule.isEmpty)
    }
    
    @MainActor func testOnInitViewStateIsLoading() {
        XCTAssertTrue(sut.viewState == .loading)
    }
    
    // MARK: Correct viewState is returned after success call
    
    @MainActor func testOnFetchSuccessEventsViewStateIsSetToSuccess() {
        
        let expectation = XCTestExpectation(description: "State is set to ready")
        
        stubEPGService.dummyEvents = .success(DummyEvents.dummyData())
        sut.getEvents()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(state == .ready)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    @MainActor func testOnFetchSuccessScheduleViewStateIsSetToSuccess() {
        
        let expectation = XCTestExpectation(description: "State is set to ready")
        
        stubEPGService.dummySchedule = .success(DummySchedule.dummyData())
        sut.getSchedule()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(state == .ready)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: When error occurs error state is set to .failue
    
    @MainActor func testOnFetchErrorEventsViewStateIsSetToFailure() {
        
        let expectation = XCTestExpectation(description: "State is set to failure")
        let dummyError = NSError()
        
        stubEPGService.dummyEvents = .failure(dummyError)
        sut.getEvents()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(state == .failure(dummyError))
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    @MainActor func testOnFetchErrorScheduleViewStateIsSetToFailure() {
        
        let expectation = XCTestExpectation(description: "State is set to failure")
        let dummyError = NSError()
        stubEPGService.dummySchedule = .failure(dummyError)
        sut.getSchedule()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(state == .failure(dummyError))
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: Correct stub data is returned on call sucess
    
    @MainActor func testOnCompleteFetchEventsCorrectDataIsReturned() {
        
        let expectation = XCTestExpectation(description: "5 events returned")
        let expectedResult = 5
        
        stubEPGService.dummyEvents = .success(DummyEvents.dummyData())
        sut.getEvents()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(self.sut.events.count == expectedResult)
            XCTAssertTrue(state == .ready)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    @MainActor func testOnCompleteFetchScheduleCorrectDataIsReturned() {
        
        let expectation = XCTestExpectation(description: "5 schedule returned")
        let expectedResult = 5
        
        stubEPGService.dummySchedule = .success(DummySchedule.dummyData())
        sut.getSchedule()
        
        sut.$viewState.dropFirst().sink { state in
            XCTAssertTrue(self.sut.schedule.count == expectedResult)
            XCTAssertTrue(state == .ready)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: Data returned in Ascending order
    
    @MainActor func testOnCompleteFetchEventsDataTheDataIsSortedInAscendingOrder() {

        let expectation = XCTestExpectation(description: "Data is sorted")
        let dummyData = DummyEvents.dummyData()
        let expectedResult = dummyData.sorted {
            ($0.startDate ?? Date()) < ($1.startDate ?? Date())
        }[0].title
        
        stubEPGService.dummyEvents = .success(dummyData)
        sut.getEvents()

        sut.$viewState.dropFirst().sink { _ in
            XCTAssertTrue(self.sut.events[0].title == expectedResult)

            expectation.fulfill()
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    @MainActor func testOnCompleteFetchScheduleDataTheDataIsSortedInAscendingOrder() {

        let expectation = XCTestExpectation(description: "Data is sorted")
        let dummyData = DummySchedule.dummyData()
        let expectedResult = dummyData.sorted {
            ($0.startDate ?? Date()) < ($1.startDate ?? Date())
        }[0].title
        
        stubEPGService.dummySchedule = .success(dummyData)
        sut.getSchedule()

        sut.$viewState.dropFirst().sink { _ in
            XCTAssertTrue(self.sut.schedule[0].title == expectedResult)

            expectation.fulfill()
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}

