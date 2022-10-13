//
//  PermissionService.swift
//  Namaz
//
//  Created by sarim khan on 05/09/2022.
//

import Foundation
import CoreLocation

class PermissionService: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    private let locationManager = CLLocationManager()
    @Published var lastLocationStatus : CLAuthorizationStatus?
    //@Published var lastLocation : CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        lastLocationStatus = manager.authorizationStatus
    }
}
