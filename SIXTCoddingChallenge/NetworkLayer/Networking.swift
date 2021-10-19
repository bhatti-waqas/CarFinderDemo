//
//  Networking.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation
//import Alamofire
import Combine

typealias Completion = (Result<[SIXTCar], Error>) -> Void
public typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
public typealias ResultHandler<T> = (ResultType<T>) -> Void

public protocol Networking {
    
    //func requestObject<T:Decodable>(_ request: URLRequestConvertible,completionHandler: @escaping DataResponseHandler<T>)
    func request<T:Decodable>(_url: URL) -> AnyPublisher<T, Error>
}
