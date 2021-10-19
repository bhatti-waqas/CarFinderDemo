//
//  ServiceProvider.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceProtocol
    //let imageLoader: ImageLoaderServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        //let imageLoader = ImageLoaderService()
        return ServicesProvider(network: network)
    }

    init(network: NetworkServiceProtocol) {
        self.network = network
        //self.imageLoader = imageLoader
    }
}
