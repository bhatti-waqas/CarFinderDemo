//
//  SceneDelegate.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let tabBarController = UITabBarController()
        coordinator = AppCoordinator(tabBarController: tabBarController, dependencyProvider: ComponentsFactory())
        coordinator?.start()
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}

