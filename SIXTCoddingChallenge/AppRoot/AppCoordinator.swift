//
//  AppCoordinator.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

enum TabName: String {
    case List
    case Map
}

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
        listView.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: nil, tag: 0)
        
        //2
        //create data store for viewModel
//        let poiDataStore: PoiDataStoreProtocol = PoiAPIDataStore()
//        let mapViewModel: MapViewModel = MapViewModel(poiDataStore)
        let mapView = MapViewController.create()
        mapView.tabBarItem = UITabBarItem(title: StringKey.Generic.MapTabName.get(), image: nil, tag: 0)
        tabBarController.viewControllers = [listView, mapView]
        
    }
}
