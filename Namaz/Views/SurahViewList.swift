//
//  SurahViewList.swift
//  Namaz
//
//  Created by sarim khan on 19/01/2023.
//

import SwiftUI

struct SurahViewList: View {
    @StateObject private var surahViewModel:SurahViewModel=SurahViewModel()
    @State private var isNavigatingToDetail:Bool=false
    @EnvironmentObject private var surahNavigationViewModel:SurahNavigationViewModel
    var body: some View {
        
        VStack{
            switch surahViewModel.surahViewState{
            case .Initial:
                ProgressView()
                
            case .Loading:
                ProgressView()
                
            case .Loaded( let surahModel):
                ScrollViewReader { proxy in
                    List(surahModel.data,id: \.number){surah in
                        SurahTileView(surah: surah,surahNavigationViewModel: surahNavigationViewModel,surahViewModel: surahViewModel)
                        
                    }
                    .onAppear{
                        surahViewModel.getSurahNumber()
                        proxy.scrollTo(surahViewModel.surahNumber,anchor: .top)
                    }
                    
                    .listStyle(.plain)
                }
                
                
                
            case .Error(let errorString):
                Text(errorString)
            }
        }
        .navigationTitle("Surah")
        
        
        
        .onAppear{
            surahViewModel.getAllNames()
        }
    }
}

struct SurahViewList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SurahViewList()
            
        }
    }
}

struct SurahTileView: View {
    var surah:Datum
    @ObservedObject var surahNavigationViewModel:SurahNavigationViewModel
    @ObservedObject var surahViewModel:SurahViewModel
    var body: some View {
        HStack{
            Text("\(surah.number). ")
            VStack(alignment:.leading){
                Text(surah.englishName)
                Text(surah.name)
                    .tracking(2)
            }
            Spacer()
            surah.number == surahViewModel.surahNumber ?
            Circle()
                .fill(Color("AccentColor"))
                .frame(width: 20, height: 20)
                
            :
            Circle()
                .fill(Color("AccentColor").opacity(0.0))
                .frame(width: 0, height: 0)
        }
        .padding([.top])
        .onTapGesture {
            surahViewModel.putSurahNumber(number: surah.number)
            surahNavigationViewModel.navigate(route: SurahRoute.detail(id: surah.number, surah: surah))
        }
        
        
    }
}
