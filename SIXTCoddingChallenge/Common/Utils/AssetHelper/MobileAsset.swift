//
//  MobileAsset.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import UIKit

public enum MobileAsset: String {
    
    case CarPlaceHolder = "mini"
    case MapIcon = "mapIcon"
    
    func getImageView() -> UIImageView {
        return self.rawValue.imgView()
    }
    
    func getImage() -> UIImage {
        return self.rawValue.img()
    }
}
