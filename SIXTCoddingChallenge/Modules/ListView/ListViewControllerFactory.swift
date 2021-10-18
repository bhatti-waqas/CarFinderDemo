//
//  ListViewControllerFactory.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/17/21.
//

import Foundation
import UIKit

final class ListViewControllerFactory {
    
    private let dataStore: SIXTCarDataStoreProtocol
    
    init(dataStore: SIXTCarDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func createListViewController(embeddedInNavigation: Bool = true) -> UIViewController {
        
        let listViewModel: ListViewModel = ListViewModel(dataStore)
        let listView: ListView = ListView()
        let viewController = ListViewController(with: listViewModel, rootView: listView)
        let tabImage = MobileAsset.CarPlaceHolder.getImage()
        viewController.tabBarItem = UITabBarItem(title: StringKey.Generic.ListTabName.get(), image: tabImage, selectedImage: tabImage)
        viewController.title = StringKey.Generic.ListTabName.get()
        guard embeddedInNavigation else { return viewController }
        return UINavigationController(rootViewController: viewController)
    }
    
}
