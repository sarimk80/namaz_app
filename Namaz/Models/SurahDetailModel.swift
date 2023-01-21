//
//  SurahDetailModel.swift
//  Namaz
//
//  Created by sarim khan on 20/01/2023.
//

import Foundation

class SurahDetailModel : Codable {
    let code: Int
    let status: String
    let data: [SurahListModel]
}

class SurahListModel : Codable {
    var id = UUID()
    let number: Int
    let name, englishName, englishNameTranslation, revelationType: String
    let numberOfAyahs: Int
    let ayahs: [Ayah]
    let edition: Edition
    
    enum CodingKeys: String, CodingKey {
        case number ,name, englishName, englishNameTranslation, revelationType
        case numberOfAyahs ,ayahs ,edition
    }
}

struct Ayah: Codable {
    var id = UUID()
    let number: Int
    let text: String
    let numberInSurah, juz, manzil, page: Int
    let ruku, hizbQuarter: Int
    let sajda: Bool
    
    enum CodingKeys: String, CodingKey {
        case number ,text, numberInSurah, juz, manzil, page
        case ruku, hizbQuarter,sajda
    }
}

struct Edition: Codable {
    let identifier, language, name, englishName: String
    let format, type, direction: String
}
