//
//  ViewController.swift
//  Mapkit_iOS
//
//  Created by 윤병일 on 2021/08/18.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  //MARK: - Properties
  
  private let mapView = MKMapView()
  
  private let locationManager = CLLocationManager()
  
  private let mapTypeSegmentControl : UISegmentedControl = {
    let sg = UISegmentedControl()
    sg.insertSegment(withTitle: "Map", at: 0, animated: true)
    sg.insertSegment(withTitle: "Satelite", at: 1, animated: true)
    sg.insertSegment(withTitle: "Hybrid", at: 2, animated: true)
    sg.addTarget(self, action: #selector(segmentControlDidTap), for: .valueChanged)
    sg.backgroundColor = .white
    sg.selectedSegmentTintColor = .blue
    sg.setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .normal)
    sg.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
    return sg
  }()
  
  private let addAnnotationButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("Add Annotation", for: .normal)
    bt.setTitleColor(.blue, for: .normal)
    bt.backgroundColor = .white
    bt.layer.cornerRadius = 5
    bt.addTarget(self, action: #selector(handleAnnotationButton), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureSegmentControl()
  }

  //MARK: - Functions
  private func configureUI() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
    
    self.mapView.delegate = self
    
    self.mapView.showsUserLocation = true
    
    [mapView, addAnnotationButton].forEach {
      view.addSubview($0)
    }
    
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    addAnnotationButton.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(50)
    }
  }
  
  private func configureSegmentControl() {
    view.addSubview(mapTypeSegmentControl)
    mapTypeSegmentControl.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
      $0.centerX.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  @objc func segmentControlDidTap(sender : UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0 : self.mapView.mapType = .standard
    case 1 : self.mapView.mapType = .satellite
    case 2 : self.mapView.mapType = .hybrid
    default : self.mapView.mapType = .standard
    }
  }
  
  @objc func handleAnnotationButton() {
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2D(latitude: 37.498244, longitude: 127.039423)
    annotation.title = "Coffee Shop"
    annotation.subtitle = "Get your delicious coffee!"
    self.mapView.addAnnotation(annotation)
  }
}

  //MARK: - extension MKMapViewDelegate
extension ViewController : MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
    mapView.setRegion(region, animated: true)
  }
}
