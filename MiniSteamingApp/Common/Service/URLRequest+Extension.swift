//
//  URLRequest+Extension.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 04/07/2022.
//

import Foundation
import Combine

extension URLRequest {
    func execute(at session: URLSession = .shared) -> AnyPublisher<(Data, URLResponse), Error> {
        session.dataTaskPublisher(for: self)
            .mapError { $0 }
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
