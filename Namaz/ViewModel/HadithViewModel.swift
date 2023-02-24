//
//  HadithViewModel.swift
//  Namaz
//
//  Created by sarim khan on 22/02/2023.
//

import Foundation
import Combine

enum HadithViewState {
    case initial
    case loading
    case loaded(hadithModel:HadithModel)
    case error(error:String)
}

class HadithViewModel: ObservableObject {
    @Published var hadithViewState:HadithViewState=HadithViewState.initial
    private let namazService:NamazService=NamazService()
    var cancellable=Set<AnyCancellable>()
    
    
    
    func getHadith(id:Int)  {
        namazService.HadithProtocol(id: id).sink { completion in
            switch completion{
            case .finished:
                break
            case .failure(let error):
                self.hadithViewState=HadithViewState.error(error: error.localizedDescription)
            }
        } receiveValue: { hadith in
            self.hadithViewState=HadithViewState.loaded(hadithModel: hadith)
        }
        .store(in: &cancellable)

    }
}
