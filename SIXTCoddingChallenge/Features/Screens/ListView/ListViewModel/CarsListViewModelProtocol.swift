//
//  CarsListViewModelType.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Combine

struct CarsListViewModelInput {
    /// called when view refresh
    let refresh: AnyPublisher<Void, Never>
}

enum CarsListState: Equatable {
    case loading
    case success([CarRowViewModel])
    case failure(NetworkLayerError)
}

extension CarsListState {
    static func == (lhs: CarsListState, rhs: CarsListState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhCars), .success(let rhCars)): return lhCars == rhCars
        case (.failure, .failure): return true
        default: return false
        }
    }
}


typealias CarListViewModelOuput = AnyPublisher<CarsListState, Never>

protocol CarsListViewModelProtocol {
    func transform(input: CarsListViewModelInput) -> CarListViewModelOuput
}
