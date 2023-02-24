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
    @State private var offset = CGPoint.zero
    
    
    
    var body: some View {
        
        VStack {
            switch surahDetailViewModel.surahDetailViewState{
            case .Initial:
                ProgressView()
                
            case .Loading:
                ProgressView()
            case .Loaded(let surahDetailModel,let arabicAyah,let englishAyah):
                
                ScrollViewReader { proxy in
                    List(0..<arabicAyah.count,id: \.self) { index in
                        VStack(alignment:.leading){
                            Text(arabicAyah[index].text)
                                .tracking(2)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                                .padding([.top, .bottom])
                            Text(englishAyah[index].text)
                            HStack{
                                arabicAyah[index].sajda ? Circle()
                                    .fill(Color("YellowColor"))
                                    .frame(width: 10,height: 10)
                                :Circle()
                                    .fill(Color.purple.opacity(0.0))
                                    .frame(width: 0,height: 0)
                                CircleBadge(ayah: surahDetailViewModel.ayahNumber, surah: surahDetailViewModel.detailSurahNumber, networkAyah: arabicAyah[index].numberInSurah, networkSurah: surahDetailModel.data.first?.number ?? 0)
                            }
                            
                            
                        }
                        .swipeActions(edge:.leading, content: {
                            Button {
                                surahDetailViewModel.putAyahNumber(number: arabicAyah[index].numberInSurah)
                                surahDetailViewModel.putDetailSurahNumber(number: surahDetailModel.data.first?.number ?? 0)
                            } label: {
                                Image(systemName: "bookmark")
                            }
                            .tint(Color("AccentColor"))
                            
                        })
                        
                        .padding([.leading,.trailing])
                    }
                    .onAppear{
                        surahDetailViewModel.getDetailSurahNumber()
                        surahDetailViewModel.getAyahNumber()
                        if(surahDetailViewModel.detailSurahNumber == surahDetailModel.data.first?.number){
                            proxy.scrollTo(surahDetailViewModel.ayahNumber,anchor: .center)
                        }
                        
                        
                    }
                    .listStyle(.plain)
                }
                
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
            VStack(alignment:.leading,spacing:8) {
                Text("English Name " + names.englishName)
                Text("Meaning " + names.englishNameTranslation)
                Text( "Number of ayahs \(names.numberOfAyahs) ")
                HStack{
                    Circle()
                        .fill(Color("AccentColor"))
                        .frame(width: 10,height: 10)
                    Text("Previous bootmark")
                        
                }
                HStack{
                    Circle()
                        .fill(Color("YellowColor"))
                        .frame(width: 10,height: 10)
                    Text("sajda")
                        
                }
                
                }
            .presentationDetents([.medium])
            
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


private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct CircleBadge: View {
    var ayah:Int = 0
    var surah:Int = 0
    var networkAyah:Int = 0
    var networkSurah:Int = 0
    var body: some View {
        if(surah == networkSurah){
            if(ayah == networkAyah){
                Circle()
                    .fill(Color("AccentColor"))
                    .frame(width: 10,height: 10)
            }
        }
        else{
            Circle()
                .fill(Color.purple.opacity(0.0))
                .frame(width: 0,height: 0)
        }
    }
}
