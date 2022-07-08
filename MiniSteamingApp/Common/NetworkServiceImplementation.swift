//
//  NetworkServiceImplementation.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import Foundation
import Combine

public protocol NetworkService {
    @discardableResult func get<T>(_ resource: Resource<T>) -> Publisher<T>
}

public final class NetworkServiceImplementation: NetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }
    
    public func get<T>(_ resource: Resource<T>) -> Publisher<T> { request(.get, resource) }
    
    @discardableResult
    func request<T: Decodable>(_ httpMethod: HttpMethod,
                               _ resource: Resource<T>) -> AnyPublisher<(T, URLResponse), Error> {
        
        guard let concreteRequest = resource.urlRequest(for: httpMethod) else {
            return .fail(NSError(domain: "url unwrapping error", code: 0, userInfo: nil))
        }
        
        return concreteRequest.execute()
            .tryMap({ (data, response) -> (T, URLResponse) in
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return (decodedResponse, response)
            })
            .eraseToAnyPublisher()
    }
}
