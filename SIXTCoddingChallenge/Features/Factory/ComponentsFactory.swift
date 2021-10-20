//
//  ComponentsFactory.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import UIKit

final class ComponentsFactory {
    
    fileprivate lazy var useCase: CarsUseCase = NetworkCarsUseCase(networkService: servicesProvider.network)
    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ComponentsFactory {
    
    func carsListNavigationController() -> UIViewController {
        let carsListViewModel: CarsListViewModel = CarsListViewModel(useCase: self.useCase)
        let listView: ListView = ListView()
        let viewController = ListViewController(with: carsListViewModel, rootView: listView)
        viewController.title = StringKey.Generic.ListTabName.get()
        return viewController
    }
    
    func carMapNavigationController() -> UIViewController {
        let mapViewModel: MapViewModel = MapViewModel(useCase: self.useCase)
        let mapView: MapView = MapView()
        let viewController = MapViewController(with: mapViewModel, rootView: mapView)
        viewController.title = StringKey.Generic.MapTabName.get()
        return viewController
    }
}
