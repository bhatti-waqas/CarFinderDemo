//
//  MapViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import MapKit
import Combine


public class MapViewModel: SIXTViewModel {
    
    var dataStore: SIXTCarDataStoreProtocol
    var cars: [SIXTCar]? = nil
    
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private (set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    private let stateDidUpdateSubject = PassthroughSubject<SIXTViewModelState, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    init(_ dataStore: SIXTCarDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public override func load() {
        super.load()
        dataStore.getCars()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error ):
                    let netWorkError = error as! NetworkError
                    self.stateDidUpdateSubject.send(.error(error: netWorkError))
                case .finished:
                    print("Do nothing")
                }
            }, receiveValue: { cars in
                self.cars = cars
                self.stateDidUpdateSubject.send(.ready)
            }).store(in: &cancellable)
    }
    
    public func getNumberOfCars() -> Int {
        return cars?.count ?? 0
    }
    
    public func getCar(at index: Int) -> SIXTCar? {
        return cars?[index]
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
