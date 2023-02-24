//
//  SplashScreen.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//
import SwiftUI

struct SplashScreen: View {
    @StateObject private var locationService:LocationService=LocationService()
    @State var pushNewView: Bool = false
    var body: some View {
        NavigationView {
            NavigationLink(destination: BottomNavigation(), isActive: $pushNewView) {
                ZStack {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                    
                    
                    VStack {
                        Image("lantern")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("AccentColor"))
                            .frame(width: 100,height: 100)
                            .padding(.bottom)
                        
                        Text("Namaz Timing")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.top)
                        

                        
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
           
        }
        
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                           pushNewView = true
                       }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
