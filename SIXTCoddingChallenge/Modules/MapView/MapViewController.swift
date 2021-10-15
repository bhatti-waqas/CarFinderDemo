//
//  MapViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import MapKit
import SDWebImageMapKit
import Combine

class MapViewController: UIViewController {
    
    private let ui: MapUI = MapUI()
    private var viewModel: MapViewModel
    private var onReady: AnyCancellable?
    private var onError: AnyCancellable?
    
    public static func create(with viewModel: MapViewModel, embededInNav: Bool = true) -> UIViewController {
        let mapView = MapViewController(with: viewModel)
        guard embededInNav else { return mapView }
        mapView.title = StringKey.Generic.MapTabName.get()
        return UINavigationController(rootViewController: mapView)
    }
    
    init(with viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.layout(in: self)
        ui.mapView.delegate = self
        viewModel.load()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        onReady = viewModel.$onReady.sink(receiveValue: { show in
            if show { self.reload() }
        })
        onError = viewModel.$onError.sink(receiveValue: { error in
            guard let error = error else { return }
            AlertHandler.showError(self, error: error)
        })
    }
    
    private func reload() {
        setupInitialMapState()
        self.addAnnotations()
    }
    
    private func setupInitialMapState() {
        let coordinateRegion = viewModel.getInitialStateCenterRegion()
        ui.mapView.setRegion(coordinateRegion, animated: true)
        ui.mapView.regionThatFits(coordinateRegion)
    }
    
    private func addAnnotations() {
        let annotations = viewModel.getAnnotations()
        ui.mapView.removeAnnotations(ui.mapView.annotations)
        ui.mapView.addAnnotations(annotations)
    }
}
//MARK: ViewModel Delegate
extension MapViewController: SIXTViewModelDelegate {
    func onSIXTViewModelReady(_ viewModel: SIXTViewModel) {
        //add annotations on map
        self.reload()
    }
    
    func onSIXTViewModelError(_ viewModel: SIXTViewModel, error: NetworkError) {
        //
        //guard let error = error.element else { return }
        AlertHandler.showError(self, error: error)
    }
}
//MARK: MapView Delegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let carAnnotation = annotation as? CarAnnotation else { return nil }
        let identifier = "CarAnnotation"
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) else {
            let annotationView = MKPinAnnotationView(annotation: carAnnotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            let imageSize = CGSize(width: 60, height: 34)
            let placeholderImage = MobileAsset.CarPlaceHolder.getImage()//.scaledTo(imageSize)
            annotationView.loadImage(withUrlString: carAnnotation.imgUrl, placeholderImage: placeholderImage, size: imageSize)
            return annotationView
        }
        annotationView.annotation = carAnnotation
        return annotationView
    }
}
