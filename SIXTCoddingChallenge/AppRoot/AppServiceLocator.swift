//
//  AppServiceLoader.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/18/21.
//

import UIKit
import Swinject

let ServiceLocator = AppServiceLocator.shared

///`AppServiceLocator` is responsible to create/manage all dependencies of the application.
final class AppServiceLocator {
    
    static let shared = AppServiceLocator()
    
    private let container = Container()
    
    //MARK: init
    private init() {
        //Register dependencies
        container.register(SIXTCarDataStoreProtocol.self, factory: { _ in SIXTCarAPIDataStore()
        }).inObjectScope(.container)
        
//        container.register(ListViewControllerFactory.self, factory: { resolver in
//            guard let apiDataStore = resolver.resolve(SIXTCarDataStoreProtocol.self) else {
//                fatalError("ListViewControllerFactory dependencies are missings.")
//            }
//            return ListViewControllerFactory(dataStore: apiDataStore)
//        }).inObjectScope(.container)
//
//        container.register(MapViewControllerFactory.self, factory: { resolver in
//            guard let apiDataStore = resolver.resolve(SIXTCarDataStoreProtocol.self) else {
//                fatalError("MapViewController dependencies are missings.")
//            }
//            return MapViewControllerFactory(dataStore: apiDataStore)
//        })
    }
    
//    func listViewControllerFactory() -> ListViewControllerFactory {
//        return container.resolve(ListViewControllerFactory.self)!
//    }
    
    func mapViewControllerFactory() -> MapViewControllerFactory {
        return container.resolve(MapViewControllerFactory.self)!
    }
    
}
