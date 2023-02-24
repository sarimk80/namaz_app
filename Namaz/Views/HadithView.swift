//
//  HadithView.swift
//  Namaz
//
//  Created by sarim khan on 22/02/2023.
//

import SwiftUI

struct HadithView: View {
    @StateObject private var hadithViewModel:HadithViewModel=HadithViewModel()
    var body: some View {
        VStack{
            switch hadithViewModel.hadithViewState{
                
            case .initial:
                ProgressView()
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error)
            case .loaded(let hadithModel):
                ScrollView{
                    VStack {
                        Spacer()
                        Text(hadithModel.hadiths.first?.text ?? "")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Spacer()
                        Text(hadithModel.metadata.name)
                        HStack{
                            Text("Book \(hadithModel.hadiths.first?.reference.book ?? 0)")
                            Text("Hadith \(hadithModel.hadiths.first?.reference.hadith ?? 0)")
                        }
                        .padding(.bottom)
                        
                        
                        
                    }
                    .padding()
                }
                
                
                
                
            }
        }
        .onAppear{
            hadithViewModel.getHadith(id: Int.random(in: 1..<6000))
        }
        .navigationTitle("Daily Hadith")
    }
}

struct HadithView_Previews: PreviewProvider {
    static var previews: some View {
        HadithView()
    }
}
