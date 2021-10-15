//
//  DataResponseModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public enum ResultType<T> {
    case success(T)
    case failure(NetworkError)
}

public struct DataResponseModel<T> {
    public let result:ResultType<T>
}
