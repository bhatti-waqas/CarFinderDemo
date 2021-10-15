//
//  ConstraintMaker.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import SnapKit
import UIKit

extension ConstraintMaker {
    
    func alignToTopSafeArea(viewController: UIViewController, offset: ConstraintOffsetTarget = 0) {
        self.top.equalTo(viewController.view.safeAreaLayoutGuide.snp.top).offset(offset)
    }
    
    func equalToSuperview(inset:Int = 0) {
        self.top.bottom.leading.trailing.equalToSuperview().inset(inset)
    }
    
    func equal(to view: UIView) {
        self.leading.trailing.top.bottom.equalTo(view)
    }
}
