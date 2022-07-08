//
//  StubEPGService.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 06/07/2022.
//

@testable import MiniSteamingApp
import Combine
import Foundation

// Can be further improved to handle more test cases
class StubEPGService: EPGService {
    
    var dummyEvents: Result<Events, Error> = .success([])
    var dummySchedule: Result<ScheduleAssets, Error> = .success([])
    
    func events() -> AnyPublisher<Result<Events, Error>, Never> {
        let response = HTTPURLResponse(url: URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getEvents")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let data = "Hello, world!".data(using: .utf8)!
        return Just((data: data, response: response))
            .map({ (data: Data, response: HTTPURLResponse) -> Result<Events, Error>  in
                    dummyEvents
            })
            .eraseToAnyPublisher()
    }
    
    func schedule() -> AnyPublisher<Result<ScheduleAssets, Error>, Never> {
        let response = HTTPURLResponse(url: URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getSchedule")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let data = "Hello, world!".data(using: .utf8)!
        return Just((data: data, response: response))
            .map({ (data: Data, response: HTTPURLResponse) -> Result<ScheduleAssets, Error>  in
                    dummySchedule
            })
            .eraseToAnyPublisher()
    }
}
