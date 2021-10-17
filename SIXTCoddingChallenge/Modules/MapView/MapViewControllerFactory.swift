//
//  MapViewControllerFactory.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/17/21.
//

import UIKit

final class MapViewControllerFactory {
    
    static func createMapViewController(embeddedInNavigation: Bool = true) -> UIViewController {
        let dataStore: SIXTCarDataStoreProtocol = SIXTCarAPIDataStore()
        let viewModel: MapViewModel = MapViewModel(dataStore)
        let mapView: MapView = MapView()
        let viewController = MapViewController(with: viewModel, rootView: mapView)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        viewController.tabBarItem = UITabBarItem(title: StringKey.Generic.MapTabName.get(), image: tabImage, selectedImage: tabImage)
        viewController.title = StringKey.Generic.MapTabName.get()
        guard embeddedInNavigation else { return viewController }
        return UINavigationController(rootViewController: viewController)
    }
    
}
