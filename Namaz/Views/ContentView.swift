//
//  ContentView.swift
//  Namaz
//
//  Created by sarim khan on 29/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var permissionService:PermissionService=PermissionService()
    var body: some View {
        switch permissionService.lastLocationStatus {
        case .authorizedAlways:
            SplashScreen()
        case .authorizedWhenInUse:
            SplashScreen()
        case .denied:
            Text("Denied")
        case .notDetermined:
            ProgressView()
        case .restricted:
            Text("Restricted")
        case .none:
            ProgressView()
        default:
            ProgressView()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


