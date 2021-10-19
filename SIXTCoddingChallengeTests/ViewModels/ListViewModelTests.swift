//
//  ListViewModelTests.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/18/21.
//

import XCTest
import Combine
@testable import SIXTCoddingChallenge

class ListViewModelTests: XCTestCase {
        
    private var cancellable = Set<AnyCancellable>()
    
    // Test successfully  looading of Cars
    func testLoadCarsSuccessfully() {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .success(getMockCarResponse())
        let viewModel = ListViewModel_v1(dataStore)
        
        // 1
        let promise = expectation(description: "Cars count isn't zero")
        
        viewModel.stateDidUpdate.sink(receiveValue: { state in
            guard case .show(let cars) = state else { return }
            //guard case .ready = state else { return }
            XCTAssertTrue(cars.count > 0 , "Cars count shouldn't be zero.")
            promise.fulfill()
        }).store(in: &cancellable)
        //When
        viewModel.load()
        wait(for: [promise], timeout: 10)
        
    }
    
    func testViewDidLoad_whenFetchingSuccessful_shouldHaveReadyState() throws {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .success(getMockCarResponse())
        let viewModel = ListViewModel_v1(dataStore)
        var readySateTriggered: Bool = false
        
        viewModel.stateDidUpdate.sink(receiveValue: { state in
            guard case .show(_) = state else { return }
            readySateTriggered = true
        }).store(in: &cancellable)
        
        //When
        viewModel.load()
        XCTAssertTrue(readySateTriggered)
    }
    
    func test_whenFetchingFails_shouldShowError() throws {
        let dataStore = MockDataStore()
        dataStore.getCarsResult = .failure(NetworkError.RequestFailed)
        let viewModel = ListViewModel_v1(dataStore)
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

extension ListViewModelTests {
    
    private func getMockCarResponse() -> [SIXTCar] {
        let sixtCar = SIXTCar(id: "WMWSW31030T222518", modelIdentifier: "mini", modelName: "MINI", name: "Vanessa", make: "BMW", group: "MINI", color: "midnight_black", series: "MINI", fuelType: "D", fuelLevel: 0.7, transmission: "M", licensePlate: "VO0259", latitude: 48.134557, longitude: 11.576921, innerCleanliness: "REGULAR", carImageUrl: "https://cdn.sixt.io/codingtask/images/mini.png")
        return [sixtCar]
    }
}

