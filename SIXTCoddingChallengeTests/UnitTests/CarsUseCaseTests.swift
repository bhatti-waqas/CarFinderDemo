//
//  CarsUseCaseTest.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import XCTest
import Combine
@testable import SIXTCoddingChallenge

class CarsUseCaseTests: XCTestCase {
    
    private let networkService = NetworkServiceMock()
    private var useCase: CarsUseCase!
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        useCase = NetworkCarsUseCase(networkService: networkService)
    }
    
    func test_fetchCarsSucceeds() {
        // Given
        var result: Result<[SIXTCar], Error>!
        let expectation = self.expectation(description: "Cars")
        let cars = getMockCarResponse()
        networkService.responses["/codingtask/cars"] = cars
        //when
        useCase.fetchCars().sink(receiveValue: { value in
            result = value
            expectation.fulfill()
        }).store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }
    
    func test_loadCarsFailes_onNetworkError() {
        // Given
        var result: Result<[SIXTCar], Error>!
        let expectation = self.expectation(description: "car")
        networkService.responses["/codingtask/cars"] = NetworkLayerError.invalidResponse

        //when
        useCase.fetchCars().sink(receiveValue: { value in
            result = value
            expectation.fulfill()
        }).store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .failure = result! else {
            XCTFail()
            return
        }
    }
}
//MARK: MockResponseBuilder
extension CarsUseCaseTests {
    
    private func getMockCarResponse() -> [SIXTCar] {
        do {
            let path = Bundle(for: CarsUseCaseTests.self).path(forResource: "Cars", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([SIXTCar].self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}

