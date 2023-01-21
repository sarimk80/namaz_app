//
//  AsmaAlHusnaViewModel.swift
//  Namaz
//
//  Created by sarim khan on 27/11/2022.
//

import Foundation
import Combine

enum AsmaAlHusnaViewState {
    case Initial
    case Loading
    case Loaded(asmaAlHusna:AsmaAlHusna)
    case Error(errorString:String)
}



class AsmaAlHusmaViewModel: ObservableObject {
    private let namazService:NamazService=NamazService()
    var cancellable=Set<AnyCancellable>()
    @Published  var asmaAlHusnaViewState:AsmaAlHusnaViewState=AsmaAlHusnaViewState.Initial
    
    func getAllNames()  {
        namazService.AsmaUlHusnaProtocol()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.asmaAlHusnaViewState = AsmaAlHusnaViewState.Error(errorString: error.localizedDescription)
                
                }
            } receiveValue: { [weak self] asmaAlHusna in
                self?.asmaAlHusnaViewState = AsmaAlHusnaViewState.Loaded(asmaAlHusna: asmaAlHusna)
            }
            .store(in: &cancellable)

    }
}
