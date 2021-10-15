//
//  MKAnnotationView.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import MapKit
import SDWebImageMapKit

//MARK: MKAnnotationView+loading
extension MKAnnotationView: ImageLazyLoading {
    
    func loadImage(withUrlString urlString: String?, placeholderImage placeholder: UIImage?, size: CGSize? = nil ) {
        image = placeholder
        guard
            let _urlString = urlString,
            let imageURL = URL(string:_urlString)
            else { return }
        guard let size = size else {
            self.sd_setImage(with: imageURL, placeholderImage: placeholder, options: .highPriority, context: .none)
            return
        }
        let transformer = SDImageResizingTransformer(size: size, scaleMode: .aspectFit)
        self.sd_setImage(with: imageURL, placeholderImage: placeholder, options: .highPriority, context: [.imageTransformer: transformer])
    }
}
