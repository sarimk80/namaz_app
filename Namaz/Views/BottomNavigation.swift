//
//  BottomNavigation.swift
//  Namaz
//
//  Created by sarim khan on 24/10/2022.
//

import SwiftUI

struct BottomNavigation: View {
    let latitude :Double
    let longitude:Double
    var body: some View {
        TabView {
            NamazHomeView(latitude: latitude, longitude: longitude)
                .tabItem {
                    Image(systemName: "clock.circle")
                    Text("Namaz Time")

                }
            Compass()
                .tabItem {
                    
                    Image(systemName: "pencil.slash")
                    Text("Compass")
                }
            AsmaAlHusnaView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("Names")
                }
            SurahViewList()
                .tabItem {
                    Image(systemName: "character.book.closed.ar")
                    Text("Quran")
                }
        }
       
    }
}

struct BottomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigation(latitude: 0.0, longitude: 0.0)
    }
}
