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
       
    private let useCase = CarsUseCaseMock()
    private var viewModel: CarsListViewModel!
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        viewModel = CarsListViewModel(useCase: useCase)
    }

    // Test successfully  looading of Cars
    func testLoadCarsSuccessfully() {
        let refresh = PassthroughSubject<Void, Never>()
        let input = CarsListViewModelInput(refresh: refresh.eraseToAnyPublisher())
        var state: CarsListState?
        let expectation = self.expectation(description: "cars")
        let cars = getMockCarResponse()
        let expectedViewModels = viewModel.viewModels(from: cars)
        useCase.fetchCarsWithReturnValue = .just(.success(cars))
        viewModel.transform(input: input).sink { value in
            guard case CarsListState.success = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        //when
        refresh.send(())
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .success(expectedViewModels))
    }
    
    func test_hasErrorState_whenDataLoadingIsFailed() {
        let refresh = PassthroughSubject<Void, Never>()
        let input = CarsListViewModelInput(refresh: refresh.eraseToAnyPublisher())
        var state: CarsListState?
        let expectation = self.expectation(description: "cars")
        useCase.fetchCarsWithReturnValue = .just(.failure(NetworkLayerError.invalidResponse))
        viewModel.transform(input: input).sink { value in
            guard case .failure = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        //when
        refresh.send(())
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .failure(NetworkLayerError.invalidResponse))
    }

}

extension ListViewModelTests {
    
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

