//
//  ListViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

final class CarsListViewModel: CarsListViewModelProtocol {
    
    private let useCase: CarsUseCaseProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(useCase: CarsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func transform(input: CarsListViewModelInput) -> CarListViewModelOuput {
        cancellables.forEach{ $0.cancel() }
        cancellables.removeAll()
        let cars = input.refresh
            .flatMap({[unowned self] in
                self.useCase.fetchCars()
            })
            .map({ result -> CarsListState in
                    switch result {
                    case .success(let cars) where cars.isEmpty: return .noResults
                    case .success(let cars): return  .success(self.viewModels(from: cars))
                    case .failure(let error):
                        return .failure(error.localizedDescription)
                    }
            })
            .replaceError(with: .noResults)
            .eraseToAnyPublisher()
        let initialState: CarListViewModelOuput = .just(.idle)
        return Publishers.Merge(initialState, cars)
            .eraseToAnyPublisher()
    }
    
    func viewModels(from cars: [SIXTCar]) -> [CarRowViewModel] {
        return cars.map( { .init(id: $0.id, name: $0.name, licensePlate: $0.licensePlate, carImageUrl: $0.carImageUrl) })
    }
    
}
