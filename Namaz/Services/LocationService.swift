//
//  LocationService.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import Foundation
import CoreLocation

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    @Published var lastLocation : CLLocationCoordinate2D?
    @Published var errorString : String = ""
    
    override init() {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {return}
    
            lastLocation = location.coordinate
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorString = error.localizedDescription
    }
}
