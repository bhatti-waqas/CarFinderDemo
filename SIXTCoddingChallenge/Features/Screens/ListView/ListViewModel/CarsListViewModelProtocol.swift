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
    case failure(String)
}


typealias CarListViewModelOuput = AnyPublisher<CarsListState, Never>

protocol CarsListViewModelProtocol {
    func transform(input: CarsListViewModelInput) -> CarListViewModelOuput
}
