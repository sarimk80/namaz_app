//
//  SurahDetailViewModel.swift
//  Namaz
//
//  Created by sarim khan on 20/01/2023.
//

import Foundation
import Combine


enum SurahDetailViewState {
    case Initial
    case Loading
    case Loaded(surahDetailModel:SurahDetailModel,arabicAyah:[Ayah],englishAyah:[Ayah])
    case Error(errorString:String)
}

class SurahDetailViewModel : ObservableObject {
    private let namazService:NamazService=NamazService()
    let defaults = UserDefaults.standard
    var cancellable=Set<AnyCancellable>()
    @Published  var surahDetailViewState:SurahDetailViewState=SurahDetailViewState.Initial
    @Published var ayahNumber:Int = 1
    @Published var detailSurahNumber:Int = 1
    
    func putAyahNumber(number:Int) {
        defaults.set(number, forKey: "ayah_number")
    }
    
    func getAyahNumber(){
        self.ayahNumber = defaults.integer(forKey: "ayah_number")
    }
    
    func putDetailSurahNumber(number:Int) {
        defaults.set(number, forKey: "detail_surah_number")
    }
    
    func getDetailSurahNumber(){
        self.detailSurahNumber = defaults.integer(forKey: "detail_surah_number")
    }
    
    func getAllNames(id:Int)  {
        namazService.SurahDetailProtocol(id: id)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.surahDetailViewState = SurahDetailViewState.Error(errorString: error.localizedDescription)
                    
                }
            } receiveValue: { [weak self] surahDetail in
                var arabicAyah:[Ayah] = surahDetail.data.first?.ayahs ?? []
                var englishAyah:[Ayah] = surahDetail.data.last?.ayahs ?? []
                self?.surahDetailViewState = SurahDetailViewState.Loaded(surahDetailModel: surahDetail,arabicAyah: arabicAyah,englishAyah: englishAyah)
            }
            .store(in: &cancellable)
        
    }
    
}
