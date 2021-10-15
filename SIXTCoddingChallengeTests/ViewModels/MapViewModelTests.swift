//
//  MapViewModelTests.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/16/21.
//

import XCTest
import Combine
@testable import SIXTCoddingChallenge

class MapViewModelTests: XCTestCase {
        
    private var cancellable = Set<AnyCancellable>()
    // Test successfully  looading of Cars
    func testLoadCarsSuccessfully() {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .success([])
        let viewModel = MapViewModel(dataStore)
        
        
        // 1
        let promise = expectation(description: "Cars count isn't zero")
        
        viewModel.$onReady.sink(receiveValue: { loaded in
            if loaded {
                //then
                XCTAssertTrue(viewModel.getNumberOfCars() > 0 , "Cars count shouldn't be zero.")
                promise.fulfill()
            }
        }).store(in: &cancellable)
        //When
        viewModel.load()
        wait(for: [promise], timeout: 10)
    }
    
    func testViewDidLoad_whenFetchingSuccessful_shouldReadyState() throws {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .success([])
        let viewModel = MapViewModel(dataStore)
        
        let promise = expectation(description: "Cars count isn't zero")
        
        viewModel.$onReady.sink(receiveValue: { loaded in
            if loaded {
                //then
                XCTAssertTrue(viewModel.getNumberOfCars() > 0 , "Cars count shouldn't be zero.")
                promise.fulfill()
            }
        }).store(in: &cancellable)
        //When
        viewModel.load()
        wait(for: [promise], timeout: 10)
        
    }
}
