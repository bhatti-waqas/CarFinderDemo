//
//  NetworkingService.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    
    case unknown, apiError(reason: String)
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

final class NetworkingService: Networking {
    
    private let session: URLSession = URLSession.shared
    
    func request<T>(_url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        let request = URLRequest(url: _url)
        return session.dataTaskPublisher(for: request)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}
