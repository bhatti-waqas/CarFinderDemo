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
        //create data store for viewModel // Dependency Injection
        let dataStore: SIXTCarDataStoreProtocol = SIXTCarAPIDataStore()
        let listViewModel: ListViewModel = ListViewModel(dataStore)
        let listView = ListViewController.create(viewModel: listViewModel)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        listView.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        
        //2
        //create data store for viewModel
        let mapViewModel: MapViewModel = MapViewModel(dataStore)
        let mapView = MapViewController.create(with: mapViewModel)
        mapView.tabBarItem = UITabBarItem(title: StringKey.Generic.MapTabName.get(), image: tabImage, selectedImage: tabImage)
        tabBarController.viewControllers = [listView, mapView]
        
    }
}
