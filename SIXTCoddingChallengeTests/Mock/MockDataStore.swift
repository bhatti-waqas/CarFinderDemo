//
//  MockDataStore.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/16/21.
//

import Foundation
import Combine
@testable import SIXTCoddingChallenge

final class MockDataStore: SIXTCarDataStoreProtocol {
    
    var getCarsResult: ResultType<[SIXTCar]> = .failure(NetworkError.IncorrectDataReturned)
    
    func fetchCars(success: @escaping ([SIXTCar]) -> (), failure: @escaping (NetworkError) -> ()) {
        switch getCarsResult {
        case .success(let cars):
            success(cars)
        case .failure(let error):
            failure(error)
        }
    }
}


