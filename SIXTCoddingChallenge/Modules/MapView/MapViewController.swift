//
//  MapViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

class MapViewController: UIViewController {
    
    private let ui: MapUI = MapUI()
    
    public static func create(embededInNav: Bool = true) -> UIViewController {
        let mapView = MapViewController()
        guard embededInNav else { return mapView }
        return UINavigationController(rootViewController: mapView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.layout(in: self)
    }
}
