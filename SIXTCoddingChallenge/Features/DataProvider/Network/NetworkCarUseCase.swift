//
//  NetworkCarUseCase.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import Combine

final class NetworkCarsUseCase: CarsUseCase {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never> {
        return networkService
            .load(Resource<[SIXTCar]>.cars(query: APIURLs.carsUrl))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[SIXTCar], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
