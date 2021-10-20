//
//  ListViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

final class CarsListViewModel: CarsListViewModelProtocol {
    private let useCase: CarsUseCase
    
    init(useCase: CarsUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: CarsListViewModelInput) -> CarListViewModelOutput {
        let cars = input.refresh
            .flatMap({[unowned self] in
                self.useCase.fetchCars()
            })
            .map({ result -> CarsListState in
                switch result {
                case .success(let cars): return  .success(self.viewModels(from: cars))
                case .failure(let error):
                    return .failure(error.localizedDescription)
                }
            })
            .eraseToAnyPublisher()
        
        let loading: CarListViewModelOutput = input.refresh.map({_ in .loading}).eraseToAnyPublisher()
        return Publishers.Merge(loading, cars)
            .eraseToAnyPublisher()
    }
    
    func viewModels(from cars: [SIXTCar]) -> [CarRowViewModel] {
        return cars.map{
            .init(
                id: $0.id,
                name: $0.name,
                licensePlate: $0.licensePlate,
                carImageUrl: $0.carImageUrl
            )
        }
    }
}
