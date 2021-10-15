//
//  MapUI.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

class MapUI: SIXTBaseUI {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "I will be showing the map YO!"
        return label
    }()
    
    override func layout(in viewController: UIViewController) {
        super.layout(in: viewController)
        viewController.view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
}
