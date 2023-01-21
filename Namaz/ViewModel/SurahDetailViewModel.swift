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
    var cancellable=Set<AnyCancellable>()
    @Published  var surahDetailViewState:SurahDetailViewState=SurahDetailViewState.Initial
    
    
    
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
