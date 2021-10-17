//
//  SIXTCarDataStore.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import Combine

protocol SIXTCarDataStoreProtocol {
    func getCars( success: @escaping (_ json: [SIXTCar]) -> (), failure: @escaping (_ error: NetworkError) -> () )
}

final class SIXTCarAPIDataStore: SIXTCarDataStoreProtocol {
    
    let network: Networking = AlamofireNetwork.shared
    let baseUrl: String = APIURLs.baseURL
    let translation: TranslationLayer = JSONTranslation()
    
    func getCars(success: @escaping ([SIXTCar]) -> (), failure: @escaping (NetworkError) -> ()) {
        
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
}
