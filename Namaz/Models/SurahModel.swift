//
//  SurahModel.swift
//  Namaz
//
//  Created by sarim khan on 19/01/2023.
//

import Foundation


class SurahModel : Codable{
    let code: Int
    let status: String
    let data: [Datum]
}

struct Datum: Codable {
    let number: Int
    let name, englishName, englishNameTranslation: String
    let numberOfAyahs: Int
    let revelationType: RevelationType
}

enum RevelationType: String, Codable {
    case meccan = "Meccan"
    case medinan = "Medinan"
}
