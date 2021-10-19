//
//  SIXTCarDataStore.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import Alamofire
import Combine

protocol SIXTCarDataStoreProtocol {
    //user result type with completion block instead of two different blocks
   // func fetchCars( success: @escaping (_ json: [SIXTCar]) -> (), failure: @escaping (_ error: NetworkError) -> () )
    func fetchCars(then completion: @escaping Completion)
    //func fetchCars( completion: @escaping (_ json: )
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never>
}

final class SIXTCarAPIDataStore: SIXTCarDataStoreProtocol {
    
//    let network: Networking = AlamofireNetwork.shared
//    let network: NetworkServiceProtocol = NetworkService(session: .shared)
    let baseUrl: String = APIURLs.baseURL
    let network: NetworkServiceProtocol = NetworkService()//NetworkingService()
    let translation: TranslationLayer = JSONTranslation()
    
//    func fetchCars(success: @escaping ([SIXTCar]) -> (), failure: @escaping (NetworkError) -> ()) {
//
//        let dataRequest = CustomDataRequest(url: baseUrl)
//        network.requestObject(dataRequest) { (response:DataResponseModel<[SIXTCar]>) in
//            switch response.result {
//            case .success(let responseModel):
//                success(responseModel)
//            case .failure(let error):
//                failure(error)
//            }
//        }
//
//    }
    
    
    func fetchCars(then completion: @escaping Completion) {
        
        let dataRequest = CustomDataRequest(url: baseUrl)
        AF.request(dataRequest)
            .validate()
            .responseDecodable(completionHandler: { (response: DataResponse<[SIXTCar], AFError>) in
                switch response.result {
                case .failure(_):
                    completion(.failure(NetworkError.RequestFailed))
                case .success(let cars) where cars.isEmpty:
                    completion(.failure(NetworkError.RequestFailed))
                case .success(let cars):
                    completion(.success(cars))
                }
            })
        
    }
    
    func fetchCars() -> AnyPublisher<Result<[SIXTCar], Error>, Never> {
        return network
            .load(Resource<[SIXTCar]>.cars(query: APIURLs.baseURL))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[SIXTCar], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
