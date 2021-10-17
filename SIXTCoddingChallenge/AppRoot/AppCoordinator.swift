//
//  AppCoordinator.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

protocol Coordinator {
    var tabBarController: UITabBarController { get set } //this is our root controlller
    func start()
}

class AppCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        //create all tabs to show
        //1
        let listViewControllerFactory = ListViewControllerFactory()
        let listViewController = listViewControllerFactory.createListViewController(embeddedInNavigation: true)
        
        
        
        //2
        //create data store for viewModel
        let dataStore: SIXTCarDataStoreProtocol = SIXTCarAPIDataStore()
        let mapViewModel: MapViewModel = MapViewModel(dataStore)
        let mapView = MapViewController.create(with: mapViewModel)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        mapView.tabBarItem = UITabBarItem(title: StringKey.Generic.MapTabName.get(), image: tabImage, selectedImage: tabImage)
        tabBarController.viewControllers = [listViewController, mapView]
        
    }
}
