//
//  NetworkCarsUseCase.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import Combine

protocol CarsUseCase {
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never>
}
