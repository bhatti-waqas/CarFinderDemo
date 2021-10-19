//
//  CarsUseCase.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

protocol CarsUseCaseProtocol {
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never>
}

final class CarsUseCase: CarsUseCaseProtocol {
    private let networkService: NetworkServiceProtocol
//    private let imageLoaderService: ImageLoaderServiceType
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        //self.imageLoaderService = imageLoaderService
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
