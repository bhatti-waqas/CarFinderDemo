//
//  AppCoordinator.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    private let tabBarController: UITabBarController
    private let dependencyProvider: ComponentsFactory
    
    init(tabBarController: UITabBarController, dependencyProvider: ComponentsFactory) {
        self.tabBarController = tabBarController
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        //create all tabs to show
        //1
        let listViewController = dependencyProvider.carsListNavigationController()
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        listViewController.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        
        //2
        let mapViewController = dependencyProvider.carMapNavigationController()
        mapViewController.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: listViewController),
            UINavigationController(rootViewController: mapViewController)
        ]
    }
}
