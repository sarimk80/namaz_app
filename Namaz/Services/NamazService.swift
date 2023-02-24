//
//  NamazService.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import Foundation
import Combine

class NamazService: NamazProtocol {
    func HadithProtocol(id: Int) -> AnyPublisher<HadithModel, Error> {
        let url = URL(string: "https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-bukhari/\(id).json")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: HadithModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    //https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-bukhari/1035.json
    // 1 - 6000
    
    
    
    func SurahDetailProtocol(id:Int) -> AnyPublisher<SurahDetailModel, Error> {
        let url = URL(string: "https://api.alquran.cloud/v1/surah/\(id)/editions/quran-uthmani,en.asad")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: SurahDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    //https://api.alquran.cloud/v1/surah/114/editions/quran-uthmani,en.asad
    
    func SurahProtocol() -> AnyPublisher<SurahModel, Error> {
        let url = URL(string: "https://api.alquran.cloud/v1/surah")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: SurahModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func NamazProtocol(latitude: Double, longitude: Double, timeStamp: Int, method: Int) -> AnyPublisher<NamazModel, Error> {
        let url = URL(string: "https://api.aladhan.com/v1/timings/\(timeStamp)?latitude=\(latitude)&longitude=\(longitude)&method=\(method)")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: NamazModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func AsmaUlHusnaProtocol() -> AnyPublisher<AsmaAlHusna,Error> {
        let url = URL(string: "https://api.aladhan.com/v1/asmaAlHusna")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{
                return $0.data
            }
            .decode(type: AsmaAlHusna.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
