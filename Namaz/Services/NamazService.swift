//
//  NamazService.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import Foundation
import Combine

class NamazService: NamazProtocol {
    
    func NamazProtocol(latitude: Double, longitude: Double, timeStamp: Int, method: Int) -> AnyPublisher<NamazModel, Error> {
        let url = URL(string: "https://api.aladhan.com/v1/timings/\(timeStamp)?latitude=\(latitude)&longitude=\(longitude)&method=\(method)")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: NamazModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
