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
    //typealias DependencyProvider = Statepr
    private let dependencyProvider: ComponentsFactory
    
    init(tabBarController: UITabBarController, dependencyProvider: ComponentsFactory) {
        self.tabBarController = tabBarController
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        //create all tabs to show
        //1
        let listViewNavigation = dependencyProvider.carsListNavigationController()
        //let listFactory = ServiceLocator.listViewControllerFactory()
        //let listViewController = listFactory.createListViewController()
        //2
//        let mapFactory = ServiceLocator.mapViewControllerFactory()
        let mapViewController = dependencyProvider.carMapNavigationController()
        tabBarController.viewControllers = [listViewNavigation, mapViewController]
    }
}
