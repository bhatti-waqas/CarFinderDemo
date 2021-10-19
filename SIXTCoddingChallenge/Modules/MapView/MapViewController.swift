//
//  MapViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import MapKit
import Combine

class MapViewController: UIViewController {
    
    private var rootView: MapView
    private var viewModel: MapViewModel
    private var cancellables: [AnyCancellable] = []
    private let load = PassthroughSubject<Void, Never>()
    
    init(with viewModel: MapViewModel, rootView: MapView) {
        self.viewModel = viewModel
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //viewModel.load()
        self.bindViewModel()
        self.load.send(())
    }
    
    //MARK: Private Methods
    private func configureUI() {
        rootView.spinner.startAnimating()
        rootView.backgroundColor = .white
        rootView.mapView.delegate = self
    }
    
    private func bindViewModel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = MapViewModelInput(load: load.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
//    private func render(_state: MapViewModelState) {
//        switch _state {
//        case .ready:
//            self.reload()
//        case .error(let error):
//            rootView.spinner.stopAnimating()
//            AlertHandler.showError(self, error: error)
//        }
//    }
    
    
    private func render(_ state: MapCarsState) {
        switch state {
        case .idle:
            print("Idle state")
        case .loading:
            rootView.spinner.startAnimating()
        case .noResults:
            rootView.spinner.stopAnimating()
        case .failure(let errorMessage):
            rootView.spinner.stopAnimating()
            AlertHandler.showAlert(self, message: errorMessage)
        case .ready:
            rootView.spinner.stopAnimating()
            self.reload()
        }
    }
    
    
    private func reload() {

        setupInitialMapRegion()
        self.addAnnotations()
    }
    
    private func setupInitialMapRegion() {
        let coordinateRegion = viewModel.getInitialStateCenterRegion()
        rootView.mapView.setRegion(coordinateRegion, animated: true)
        rootView.mapView.regionThatFits(coordinateRegion)
    }
    
    private func addAnnotations() {
        let annotations = viewModel.getAnnotations()
        rootView.mapView.addAnnotations(annotations)
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
            let placeholderImage = MobileAsset.CarPlaceHolder.getImage()
            annotationView.loadImage(withUrlString: carAnnotation.imgUrl, placeholderImage: placeholderImage, size: imageSize)
            return annotationView
        }
        annotationView.annotation = carAnnotation
        return annotationView
    }
}
