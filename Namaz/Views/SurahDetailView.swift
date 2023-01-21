//
//  SurahDetailView.swift
//  Namaz
//
//  Created by sarim khan on 20/01/2023.
//

import SwiftUI

struct SurahDetailView: View {
    var id:Int
    var names : Datum
    @StateObject private var surahDetailViewModel:SurahDetailViewModel=SurahDetailViewModel()
    @State var isSheetOpen:Bool=false
    var body: some View {
        
        VStack {
            switch surahDetailViewModel.surahDetailViewState{
            case .Initial:
                ProgressView()
                
            case .Loading:
                ProgressView()
            case .Loaded(let surahDetailModel,let arabicAyah,let englishAyah):
                
                List(0..<arabicAyah.count,id: \.self) { index in
                    VStack(alignment:.leading){
                        Text(arabicAyah[index].text)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                            .padding([.top, .bottom])
                        Text(englishAyah[index].text)
                        arabicAyah[index].sajda ? Circle()
                            .fill(Color("AccentColor"))
                            .frame(width: 10,height: 10)
                        :Circle()
                            .fill(Color.purple.opacity(0.0))
                            .frame(width: 0,height: 0)
                            
                    }
                    
                    
                }
                .listStyle(.grouped)
                
            case .Error(let errorString):
                Text(errorString)
            }
        }
        .onAppear{
            surahDetailViewModel.getAllNames(id: self.id)
        }
        .navigationTitle(names.name)
        .toolbar {
            Image(systemName: "folder.badge.plus")
                .onTapGesture {
                    isSheetOpen.toggle()
                }
        }
        .sheet(isPresented: $isSheetOpen) {
            VStack {
                Text(names.englishName)
                Text(names.englishNameTranslation)
                Text(" \(names.numberOfAyahs) ")
            }.frame(minWidth: 0 , maxWidth: .infinity, minHeight: 20 ,maxHeight: 30)
            
        }
        
        
        
    }
}

struct SurahDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SurahDetailView(id: 114,names: Datum(number: 1, name: "Dummy", englishName: "Dummy", englishNameTranslation: "Dummy", numberOfAyahs: 1, revelationType: RevelationType.medinan))
        }
        
    }
}
