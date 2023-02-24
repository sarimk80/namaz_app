//
//  BottomNavigation.swift
//  Namaz
//
//  Created by sarim khan on 24/10/2022.
//

import SwiftUI

struct BottomNavigation: View {
    @StateObject private var locationService:LocationService=LocationService()
    @StateObject private var surahNavigationViewModel=SurahNavigationViewModel()
    var body: some View {
        TabView {
            NavigationStack{
                HadithView()
            }
           
                .tabItem {
                    Image(systemName: "house")
                    Text("Hadith")
                    
                }
            NavigationStack {
                NamazHomeView(latitude: locationService.lastLocation?.latitude ?? 0.0, longitude: locationService.lastLocation?.longitude ?? 0.0)
                
            }
            .tabItem {
                Image(systemName: "clock.circle")
                Text("Namaz Time")
                
            }
            NavigationStack {
                Compass()
                
            }
            .tabItem {
                
                Image(systemName: "pencil.slash")
                Text("Compass")
            }
            NavigationStack {
                AsmaAlHusnaView()
                
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle.portrait.fill")
                Text("Names")
            }
            NavigationStack(path: $surahNavigationViewModel.surahPath) {
                SurahViewList()
                    .navigationDestination(for: SurahRoute.self, destination: { route in
                        switch route {
                        case .detail(let id,let surah):
                            SurahDetailView(id: id, names: surah)
                        }
                    })
                    .environmentObject(surahNavigationViewModel)
                
            }
            
            
            .tabItem {
                Image(systemName: "character.book.closed.ar")
                Text("Quran")
            }
            
            
        }
        
    }
}

struct BottomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigation()
    }
}
