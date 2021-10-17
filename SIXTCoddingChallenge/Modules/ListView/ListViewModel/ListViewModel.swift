//
//  ListViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation
import Combine

/// define all states
enum ListViewModelState {
    case show([ListCellViewModel])
    case error(NetworkError)
}

public class ListViewModel {
    
    var dataStore: SIXTCarDataStoreProtocol
    var cars: [SIXTCar]? = nil
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    private let stateDidUpdateSubject = PassthroughSubject<ListViewModelState,Never>()
    
    init(_ dataStore: SIXTCarDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func load() {
        dataStore.getCars(success: { [weak self ] cars in
            guard let self = self else { return }
            let listCellViewModels = cars.map(self.makeListCellViewModel(with:))
            self.stateDidUpdateSubject.send(.show(listCellViewModels))
            
        }, failure: { error in
            self.stateDidUpdateSubject.send(.error(error))
        })
    }
    
    //MARK: Private methods
    private func makeListCellViewModel(with car: SIXTCar) -> ListCellViewModel {
        .init(id: car.id, name: car.name, licensePlate: car.licensePlate, carImageUrl: car.carImageUrl)
    }
}
