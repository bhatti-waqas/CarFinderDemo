//
//  NetworkService.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }
    
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        guard let request = resource.request else {
            return Fail(error: NetworkLayerError.invalidRequest).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkLayerError.invalidRequest }
            .print()
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkLayerError.invalidResponse).eraseToAnyPublisher()
                }

                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkLayerError.dataLoadingError(statusCode: response.statusCode, data: data)).eraseToAnyPublisher()
                }
                return Just(data)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
