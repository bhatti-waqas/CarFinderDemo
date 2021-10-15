//
//  MapViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import MapKit

public class MapViewModel: SIXTViewModel {
    
    var dataStore: SIXTCarDataStoreProtocol
    var cars: [SIXTCar]? = nil
    
    init(_ dataStore: SIXTCarDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public override func load() {
        super.load()
        dataStore.getCars(success: { cars in
            self.cars = cars
            self.makeReady()
            
        }, failure: { error in
            self.throwError(with: error)
        })
    }
    
    public func getNumberOfCars() -> Int {
        return cars?.count ?? 0
    }
    
    public func getCar(at index: Int) -> SIXTCar? {
        return cars?[index]
    }
    
    // MARK: - Map Coord Helpers
    public func getInitialStateCenterRegion() -> MKCoordinateRegion {
        let centerPoint = CLLocationCoordinate2DMake((48.134557 + 48.193826)/2, (11.576921 + 11.563875)/2)
        let floatForRadiusInMiles = 10.0 // we can ignore this i have taken this for my custom radius property
        let scalingFactor: Double = abs((cos(2 * Double.pi * centerPoint.latitude / 360.0)))
        let coordinateSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: floatForRadiusInMiles / 69.0, longitudeDelta: floatForRadiusInMiles / (scalingFactor * 69.0))
        return MKCoordinateRegion(center: centerPoint, span: coordinateSpan)
    }
    
    /// Create annotations from Cars
    public func getAnnotations() -> [CarAnnotation] {
        guard self.isReady(false) else { return [] }
        var annotations: [CarAnnotation] = []
        guard let cars = self.cars else{ return [] }
        for car in cars {
            let coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(car.latitude), longitude: CLLocationDegrees(car.longitude))
            let annotation = CarAnnotation(title: car.name, coordinate: coordinate, imgUrl: car.carImageUrl)
            annotations.append(annotation)
        }
        return annotations
    }

}
