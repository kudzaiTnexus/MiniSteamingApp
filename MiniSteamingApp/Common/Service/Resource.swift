//
//  Resource.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import Foundation

public struct Resource<T: Decodable> {
    public var urlString: String
    public var path: String
    public var headers: [String: String]
    public var parameters: [String: CustomStringConvertible]?
    public var body: Data?

    public init(urlString: String,
         path: String,
         headers: [String: String] = [:],
         parameters: [String: CustomStringConvertible]? = nil,
         body: Data? = nil) {
        self.urlString = urlString
        self.path = path
        self.headers = headers
        self.parameters = parameters
        self.body = body
    }
    
    internal func urlRequest(for httpMethod: HttpMethod) -> URLRequest? {
        
        guard var components = URLComponents(string: urlString + path) else {
            return nil
        }
        
        components.queryItems = parameters?.map({ (key, value) in
            URLQueryItem(name: key, value: parameters?[key]?.description)
        })
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        headers.forEach({ (key, value) in
         request.setValue(value, forHTTPHeaderField: key)
        })
        request.httpBody = body
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}
