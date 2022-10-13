//
//  NamazViewModel.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import Foundation
import Combine

enum NamazViewState {
    case Initial
    case Loading
    case Loaded(namazModel:NamazModel)
    case Error(errorString:String)
}

class NamazViewModel:ObservableObject{
    private let namazService:NamazService=NamazService()
    var cancellable=Set<AnyCancellable>()
    @Published  var namazViewState:NamazViewState=NamazViewState.Initial
    
    func getNamazTiming(latitude:Double, longitude:Double)  {
        namazService.NamazProtocol(latitude: latitude, longitude: longitude, timeStamp: Int(Date().timeIntervalSince1970), method: 1)
            .sink {[weak self] completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self?.namazViewState = NamazViewState.Error(errorString: error.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] namazModel in
                self?.namazViewState = NamazViewState.Loaded(namazModel: namazModel)
            }
            .store(in: &cancellable)
        
    }
    
}
