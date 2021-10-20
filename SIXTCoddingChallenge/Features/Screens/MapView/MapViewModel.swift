//
//  MapViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation
import MapKit
import Combine

final class MapViewModel: MapViewModelProtocol {
    
    private let useCase: CarsUseCase
    private var cars: [SIXTCar]? = nil
    
    init(useCase: CarsUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: MapViewModelInput) -> MapViewModelOutput {
        let cars = input.appear
            .flatMap({[unowned self] in
                self.useCase.fetchCars()
            })
            .map({ result -> MapCarsState in
                    switch result {
                    case .success(let cars) where cars.isEmpty: return .noResults
                    case .success(let cars):
                        self.cars = cars
                        return .ready
                    case .failure(let error):
                        return .failure(error.localizedDescription)
                    }
            })
            .replaceError(with: .noResults)
            .eraseToAnyPublisher()
        
        let loading: MapViewModelOutput = input.appear.map({_ in .loading}).eraseToAnyPublisher()
        return Publishers.Merge(loading, cars)
            .eraseToAnyPublisher()
    }
    
    private func getLongitudes() -> (minLong: Double, maxLong: Double) {
        guard let cars = cars, cars.count > 0 else { return (0,0) }
        let miniLong = cars.min(by: { $0.longitude < $1.longitude })?.longitude ?? 0.0
        let maxLong = cars.max(by: { $0.longitude < $1.longitude })?.longitude ?? 0.0
        return (miniLong, maxLong)
    }
    
    private func getLatitudes() -> (minLat: Double, maxLat: Double) {
        guard let cars = cars, cars.count > 0 else { return (0,0) }
        let minLat = cars.min(by: { $0.latitude < $1.latitude })?.latitude ?? 0.0
        let maxLat = cars.max(by: { $0.latitude < $1.latitude })?.latitude ?? 0.0
        return (minLat, maxLat)
    }
    
    // MARK: - Map Coord Helpers
    public func getInitialStateCenterRegion() -> MKCoordinateRegion {
        let longitudeCoordinates = getLongitudes()
        let latitudeCoordinates = getLatitudes()
        let centerPoint = CLLocationCoordinate2DMake((latitudeCoordinates.minLat + latitudeCoordinates.maxLat)/2, (longitudeCoordinates.minLong + longitudeCoordinates.maxLong)/2)
        let floatForRadiusInMiles = 10.0 // we can ignore this i have taken this for my custom radius property
        let scalingFactor: Double = abs((cos(2 * Double.pi * centerPoint.latitude / 360.0)))
        let coordinateSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: floatForRadiusInMiles / 69.0, longitudeDelta: floatForRadiusInMiles / (scalingFactor * 69.0))
        return MKCoordinateRegion(center: centerPoint, span: coordinateSpan)
    }
    
    /// Create annotations from Cars
    public func getAnnotations() -> [CarAnnotation] {
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

