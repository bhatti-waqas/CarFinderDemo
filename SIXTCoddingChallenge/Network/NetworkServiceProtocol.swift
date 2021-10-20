//
//  NetworkServiceType.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

protocol NetworkServiceProtocol: AnyObject {
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
}
/// Defines the Network service errors.
enum NetworkLayerError {
    case invalidRequest
    case invalidResponse
    case dataLoadingError(statusCode: Int, data: Data)
    case jsonDecodingError(error: Error)
}

extension NetworkLayerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return StringKey.Error.InvalidRequestError.get()
        case .invalidResponse:
            return StringKey.Error.InvalidResponseError.get()
        case .dataLoadingError:
            return StringKey.Error.InvalidDataError.get()
        case .jsonDecodingError:
            return StringKey.Error.ErrorDecoding.get()
        }
    }
}
