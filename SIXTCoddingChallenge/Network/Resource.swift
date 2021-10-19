//
//  Resource.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}

extension Resource {

    static func cars(query: String) -> Resource<[SIXTCar]> {
        let url = URL(string: query)!
        return Resource<[SIXTCar]>(url: url)
    }
}
