//
//  SIXTCar.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

struct SIXTCar: Decodable {
    public var id: String
    public var modelIdentifier: String
    public var modelName: String
    public var name: String
    public var make: String
    public var group: String
    public var color: String
    public var series: String
    public var fuelType: String
    public var fuelLevel: Double
    public var transmission: String
    public var licensePlate: String
    public var latitude: Double
    public var longitude: Double
    public var innerCleanliness: String
    public var carImageUrl: String
}
