//
//  MapView.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/18/21.
//

import UIKit
import SnapKit
import MapKit

final class MapView: UIView  {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(mapView)
        contentView.addSubview(spinner)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
