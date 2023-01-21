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
    @Published var magneticHeading : Double = .zero
    
    override init() {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
    
            lastLocation = location.coordinate
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        magneticHeading = -1 * newHeading.magneticHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorString = error.localizedDescription
    }
}
