//
//  ComponentsFactory.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import UIKit

final class ComponentsFactory {
    
    fileprivate lazy var useCase: CarsUseCaseProtocol = CarsUseCase(networkService: servicesProvider.network)

    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ComponentsFactory {
    
    func carsListNavigationController() -> UINavigationController {
        let carsListViewModel: CarsListViewModel = CarsListViewModel(useCase: self.useCase)
        let listView: ListView = ListView()
        let viewController = ListViewController(with: carsListViewModel, rootView: listView)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        viewController.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        viewController.title = StringKey.Generic.ListTabName.get()
        return UINavigationController(rootViewController: viewController)
    }
    
    func carMapNavigationController() -> UINavigationController {
        let mapViewModel: MapViewModel = MapViewModel(useCase: self.useCase)
        let mapView: MapView = MapView()
        let viewController = MapViewController(with: mapViewModel, rootView: mapView)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        viewController.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        viewController.title = StringKey.Generic.MapTabName.get()
        return UINavigationController(rootViewController: viewController)
    }
}
