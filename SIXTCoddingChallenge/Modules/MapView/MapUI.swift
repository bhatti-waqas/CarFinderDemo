//
//  MapUI.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import MapKit
import SnapKit

class MapUI: SIXTBaseUI {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func layout(in viewController: UIViewController) {
        super.layout(in: viewController)
        viewController.view.addSubview(contentView)
        contentView.addSubview(mapView)
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.alignToTopSafeArea(viewController: viewController, offset: 20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
