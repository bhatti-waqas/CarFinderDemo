//
//  ServiceProvider.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation

final class ServicesProvider {
    //depndenices container
    let network: NetworkServiceProtocol
    
    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        return ServicesProvider(network: network)
    }

    init(network: NetworkServiceProtocol) {
        self.network = network
    }
}
