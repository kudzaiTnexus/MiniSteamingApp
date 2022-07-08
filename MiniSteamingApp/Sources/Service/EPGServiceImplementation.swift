//
//  EPGServiceImplementation.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation
import Combine

protocol EPGService {
    func events() -> AnyPublisher<Result<Events, Error>, Never>
    func schedule() -> AnyPublisher<Result<ScheduleAssets, Error>, Never>
}

final class EPGServiceImplementation: EPGService {
    
    private let TIMEOUT_TIME = 45.0
    private let baseUrl: String = "https://us-central1-dazn-sandbox.cloudfunctions.net"
    
    private var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func events() -> AnyPublisher<Result<Events, Error>, Never> {
        return service
            .get(Resource<Events>(urlString: baseUrl, path: "/getEvents"))
            .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError:nil)
            .subscribe(on: DispatchQueue.global())
            .map { .success($0.0) }
            .catch {
                error -> AnyPublisher<Result<Events, Error>, Never> in .just(.failure(error))
            }
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    func schedule() -> AnyPublisher<Result<ScheduleAssets, Error>, Never> {
        return service
            .get(Resource<ScheduleAssets>(urlString: baseUrl, path: "/getSchedule"))
            .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError:nil)
            .subscribe(on: DispatchQueue.global())
            .map { .success($0.0) }
            .catch {
                error -> AnyPublisher<Result<ScheduleAssets, Error>, Never> in .just(.failure(error))
            }
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
}


