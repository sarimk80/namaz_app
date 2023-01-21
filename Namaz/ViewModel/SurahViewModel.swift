//
//  SurahViewModel.swift
//  Namaz
//
//  Created by sarim khan on 19/01/2023.
//

import Foundation
import Combine

enum SurahViewState {
    case Initial
    case Loading
    case Loaded(surahModel:SurahModel)
    case Error(errorString:String)
}

class SurahViewModel : ObservableObject{
    private let namazService:NamazService=NamazService()
    var cancellable=Set<AnyCancellable>()
    @Published  var surahViewState:SurahViewState=SurahViewState.Initial
    
    func getAllNames()  {
        namazService.SurahProtocol()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.surahViewState = SurahViewState.Error(errorString: error.localizedDescription)
                
                }
            } receiveValue: { [weak self] surah in
                self?.surahViewState = SurahViewState.Loaded(surahModel: surah)
            }
            .store(in: &cancellable)

    }
}
