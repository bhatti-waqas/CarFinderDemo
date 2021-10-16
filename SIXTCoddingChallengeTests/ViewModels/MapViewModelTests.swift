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
        
        viewModel.stateDidUpdate.sink(receiveValue: { state in
            guard case .ready = state else { return }
            XCTAssertTrue(viewModel.getNumberOfCars() > 0 , "Cars count shouldn't be zero.")
            promise.fulfill()
        }).store(in: &cancellable)
        
        //When
        viewModel.load()
        wait(for: [promise], timeout: 10)
        
    }
    
    func testViewDidLoad_whenFetchingSuccessful_shouldHaveReadyState() throws {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .success([])
        let viewModel = MapViewModel(dataStore)
        var readySateTriggered: Bool = false
        
        viewModel.stateDidUpdate.sink(receiveValue: { state in
            guard case .ready = state else { return }
            readySateTriggered = true
        }).store(in: &cancellable)
        
        //When
        viewModel.load()
        XCTAssertTrue(readySateTriggered)
    }
    
    func test_whenFetchingFails_shouldShowError() throws {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .failure(NetworkError.RequestFailed)
        let viewModel = MapViewModel(dataStore)
        var errorSateTriggered: Bool = false
        
        viewModel.stateDidUpdate.sink(receiveValue: { state in
            guard case .error(_) = state else { return }
            errorSateTriggered = true
        }).store(in: &cancellable)
        
        //When
        viewModel.load()
        // Then
        XCTAssertTrue(errorSateTriggered)
    }
}
