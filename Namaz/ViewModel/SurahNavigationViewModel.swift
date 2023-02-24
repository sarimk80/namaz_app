//
//  SurahNavigationViewModel.swift
//  Namaz
//
//  Created by sarim khan on 07/02/2023.
//

import Foundation
import SwiftUI

enum SurahRoute: Hashable {
    
    case detail(id:Int,surah:Datum)
}

class SurahNavigationViewModel:ObservableObject{
    @Published var surahPath = NavigationPath()
    
    func navigate(route:SurahRoute)  {
        surahPath.append(route)
       }
}
