//
//  Helpers.swift
//  Namaz
//
//  Created by sarim khan on 10/10/2022.
//

import Foundation

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

func getDate(myDate:String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.date(from: myDate) // replace Date String
}
