//
//  asmaAlHusna.swift
//  Namaz
//
//  Created by sarim khan on 27/11/2022.
//

import Foundation

struct AsmaAlHusna:Codable {
    let code:Int
    let status:String
    let data:[MyData]
}

struct MyData:Codable {
    let name, transliteration: String
    let number: Int
    let en: En
}

struct En:Codable{
    let meaning: String
}




