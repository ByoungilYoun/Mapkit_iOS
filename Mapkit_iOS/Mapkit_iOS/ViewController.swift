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
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  //MARK: - Functions
  private func configureUI() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
    self.mapView.showsUserLocation = true
    
    view.addSubview(mapView)
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
