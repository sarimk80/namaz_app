//
//  ContentView.swift
//  namazWatch Watch App
//
//  Created by sarim khan on 12/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("lantern")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: 50,height: 50)
                
                Text("Namaz Timing")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.top)
                
                
            }
        }
        .toolbarColorScheme(.light, in: .navigationBar)
        
        .toolbarBackground(
            Color("BackgroundColor"),
            in: .navigationBar)
        .toolbarBackground(.visible, in: .navigationBar)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
