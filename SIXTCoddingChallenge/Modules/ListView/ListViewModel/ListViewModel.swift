//
//  ListViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public class ListViewModel: SIXTViewModel {
    
    var dataStore: SIXTCarDataStoreProtocol
    var cars: [SIXTCar]? = nil
    
    init(_ dataStore: SIXTCarDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public override func load() {
        super.load()
        dataStore.getCars(success: { cars in
            self.cars = cars
            self.makeReady()
            
        }, failure: { error in
            self.throwError(with: error)
        })
    }
    
    public func getNumberOfCars() -> Int {
        return cars?.count ?? 0
    }
    
    public func getCar(at index: Int) -> SIXTCar? {
        return cars?[index]
    }
}
