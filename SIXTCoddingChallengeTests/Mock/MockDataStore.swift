//
//  MockDataStore.swift
//  SIXTCoddingChallengeTests
//
//  Created by Waqas Naseem on 10/16/21.
//

import Foundation
import Combine
@testable import SIXTCoddingChallenge

final class MockDataStore: SIXTCarDataStoreProtocol {
    
    var getCarsResult: ResultType<[SIXTCar]>?
        
    func getCars() -> AnyPublisher<[SIXTCar], Error> {
        Deferred {
            Future { handler in
                switch self.getCarsResult {
                case .success(_)?:
                    handler(.success(self.getMockResponse()))
                case .failure(let error)?:
                    handler(.failure(error))
                case .none:
                    handler(.failure(NetworkError.RequestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getCars(success: @escaping ([SIXTCar]?) -> (), failure: @escaping (NetworkError) -> ()) {
        
    }
    
    private func getMockResponse() -> [SIXTCar] {
        let path = Bundle(for: type(of: self)).path(forResource: "MockCarsResponse", ofType: "json")!
        let data = NSData(contentsOfFile: path)! as Data
        let json = try! JSONDecoder().decode([SIXTCar].self, from: data)
        return json
    }
    
}

//final class MockDataStoreViewModelLoad: PoiDataStoreProtocol {
//    var isLoadMethodCalled: Bool = false
//
//    func getPois(with nePoint: Coordinate, swPoint: Coordinate) -> Observable<[POI]> {
//        isLoadMethodCalled = true
//        return .empty()
//    }
//}

