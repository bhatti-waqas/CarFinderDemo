//
//  Networking.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

import Alamofire

public typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
public typealias ResultHandler<T> = (ResultType<T>) -> Void

public protocol Networking {
    
    func requestObject<T:Decodable>(_ request: URLRequestConvertible,completionHandler: @escaping DataResponseHandler<T>)
}
