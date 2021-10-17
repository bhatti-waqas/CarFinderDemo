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
        let listViewController = ListViewControllerFactory.createListViewController()
        //2
        let mapViewController = MapViewControllerFactory.createMapViewController()
        tabBarController.viewControllers = [listViewController, mapViewController]
    }
}
