//
//  AsmaAlHusnaView.swift
//  Namaz
//
//  Created by sarim khan on 27/11/2022.
//

import SwiftUI

struct AsmaAlHusnaView: View {
    
    @StateObject private var asmaAlHusnaViewModel:AsmaAlHusmaViewModel=AsmaAlHusmaViewModel()
    
    var body: some View {
        
            VStack{
                switch asmaAlHusnaViewModel.asmaAlHusnaViewState{
                case .Initial:
                    ProgressView()
                    
                case .Loading:
                    ProgressView()
                    
                case .Loaded(let asmaAlHusna):
                    ScrollViewReader { proxy in
                        List(asmaAlHusna.data,id: \.number){data in
                            HStack{
                                Text("\(data.number)")
                                Text(data.transliteration)
                                    .padding(.leading)
                                Spacer()
                                Text(data.name)
                            }
                        }
                        .listStyle(.plain)
                    }
                   
                    
                    
                case .Error(let errorString):
                    Text(errorString)
                }
            }
            
            .navigationTitle("Asma Al Husna")
        
        
        .onAppear{
            asmaAlHusnaViewModel.getAllNames()
        }
       
           
    }
        
}

struct AsmaAlHusnaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AsmaAlHusnaView()
        }
        
    }
}
