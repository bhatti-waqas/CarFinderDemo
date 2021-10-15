//
//  SIXTCarDataStore.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import Combine

protocol SIXTCarDataStoreProtocol {
    func getCars() ->  AnyPublisher<[SIXTCar], Error>
    func getCars( success: @escaping (_ json: [SIXTCar]?) -> (), failure: @escaping (_ error: NetworkError) -> () )
}

final class SIXTCarAPIDataStore: SIXTCarDataStoreProtocol {
    
    let network: Networking = AlamofireNetwork.shared
    let baseUrl: String = APIURLs.baseURL
    let translation: TranslationLayer = JSONTranslation()
    
    func getCars(success: @escaping ([SIXTCar]?) -> (), failure: @escaping (NetworkError) -> ()) {
        
        let dataRequest = CustomDataRequest(url: baseUrl)
        
        
        network.requestObject(dataRequest) { (response:DataResponseModel<[SIXTCar]>) in
            switch response.result {
            case .success(let responseModel):
                success(responseModel)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getCars() -> AnyPublisher<[SIXTCar], Error> {
        Deferred {
            Future { handler in
                self.getCars(success: { cars in
                    handler(.success(cars ?? []))
                }, failure: { error in
                    handler(.failure(error))
                })
            }
        }.eraseToAnyPublisher()
    }
}
