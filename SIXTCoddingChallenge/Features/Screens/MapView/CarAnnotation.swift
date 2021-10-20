//
//  CarAnnotation.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import MapKit

final class CarAnnotation : NSObject, MKAnnotation {
    public let title: String?
    public let coordinate: CLLocationCoordinate2D
    public let imgUrl: String

    init(title: String?, coordinate: CLLocationCoordinate2D, imgUrl: String) {
        self.title = title
        self.imgUrl = imgUrl
        self.coordinate = coordinate
        super.init()
    }
}
