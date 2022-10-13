//
//  NamazProtocol.swift
//  Namaz
//
//  Created by sarim khan on 10/09/2022.
//

import Foundation
import Combine

protocol NamazProtocol {
    func NamazProtocol(latitude: Double, longitude: Double,timeStamp:Int,method:Int) -> AnyPublisher<NamazModel,Error>
}
