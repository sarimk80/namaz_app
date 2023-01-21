//
//  SurahViewList.swift
//  Namaz
//
//  Created by sarim khan on 19/01/2023.
//

import SwiftUI

struct SurahViewList: View {
    @StateObject private var surahViewModel:SurahViewModel=SurahViewModel()
    var body: some View {
        NavigationView {
            
            VStack{
                switch surahViewModel.surahViewState{
                case .Initial:
                    ProgressView()
                    
                case .Loading:
                    ProgressView()
                    
                case .Loaded( let surahModel):
                    ScrollViewReader { proxy in
                            
                        
                        
                        List(surahModel.data,id: \.number){surah in
                            NavigationLink {
                                SurahDetailView(id: surah.number,names: surah)
                            } label: {
                                SurahTileView(surah: surah)
                            }

                            
                        }
                        .listStyle(.plain)
                        .onAppear{
                            //proxy.scrollTo(30,anchor: .top)
                        }
                    }
                    
                    
                    
                case .Error(let errorString):
                    Text(errorString)
                }
            }
            .navigationTitle("Surah")
        }
        .onAppear{
            surahViewModel.getAllNames()
        }
    }
}

struct SurahViewList_Previews: PreviewProvider {
    static var previews: some View {
        SurahViewList()
    }
}

struct SurahTileView: View {
    var surah:Datum
    var body: some View {
        HStack{
            Text("\(surah.number). ")
            VStack{
                Text(surah.englishName)
                Text(surah.name)
            }
        }
        .padding([.top])
        
        
    }
}
