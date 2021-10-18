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
        let listFactory = ServiceLocator.listViewControllerFactory()
        let listViewController = listFactory.createListViewController()
        //2
        let mapFactory = ServiceLocator.mapViewControllerFactory()
        let mapViewController = mapFactory.createMapViewController()
        tabBarController.viewControllers = [listViewController, mapViewController]
    }
}
