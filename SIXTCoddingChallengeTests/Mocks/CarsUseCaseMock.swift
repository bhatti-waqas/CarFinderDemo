//
//  CarsUseCaseTypeMock.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import XCTest
import Combine
@testable import SIXTCoddingChallenge

class CarsUseCaseMock: CarsUseCase {
    
    var fetchCarsWithReturnValue: AnyPublisher<Result<[SIXTCar], Error>, Never>!
    
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never> {
        return fetchCarsWithReturnValue
    }
}
