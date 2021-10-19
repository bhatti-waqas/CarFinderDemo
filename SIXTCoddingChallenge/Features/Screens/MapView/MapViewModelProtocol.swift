//
//  MapListViewModelProtocol.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import Combine

struct MapViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
}

enum MapCarsState: Equatable {
    case loading
    case ready
    case noResults
    case failure(String)
}


typealias MapViewModelOutput = AnyPublisher<MapCarsState, Never>

protocol MapViewModelProtocol {
    func transform(input: MapViewModelInput) -> MapViewModelOutput
}
