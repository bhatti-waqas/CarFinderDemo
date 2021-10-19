//
//  UIImageView.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import UIKit
import SDWebImage

protocol ImageLazyLoading {
    func loadImage(withUrlString urlString:String?,placeholderImage placeholder:UIImage?, size: CGSize?)
}
//MARK: UImageView+loading
extension UIImageView: ImageLazyLoading {
    
    func loadImage(withUrlString urlString: String?, placeholderImage placeholder: UIImage?, size: CGSize? = nil) {
        image = placeholder
        guard
            let _urlString = urlString,
            let imageURL = URL(string:_urlString)
            else { return }
        self.sd_setImage(with: imageURL, placeholderImage: placeholder, options: .highPriority, context: .none)
    }
}
//MARK: UIImage+Scaling
extension UIImage {
    
    func scaledTo(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
}
