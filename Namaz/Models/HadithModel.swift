//
//  HadithModel.swift
//  Namaz
//
//  Created by sarim khan on 22/02/2023.
//

import Foundation

class HadithModel: Codable{
    
    let metadata: Metadata
    let hadiths: [Hadith]
    
}

class Hadith: Codable {
    let hadithnumber, arabicnumber: Int
    let text: String
    let grades: [String]
    let reference: Reference
    
}

class Reference: Codable {
    let book, hadith: Int
    
}


class Metadata: Codable {
    let name: String
    //let section: Section
    
}

class Section: Codable {
    let the15: String
    
}
