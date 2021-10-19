//
//  Publisher.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

extension Publisher {
        
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}
