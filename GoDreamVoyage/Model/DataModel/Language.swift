//
//  File.swift
//  GoDreamVoyage
//
//  Created by Nathan on 22/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

enum Language: CaseIterable {
    case Arabic
    case Chinese
    case Deutsch
    case English
    case French
    case Italian
    case Japanese
    case Portugese
    case Russian
    case Spanish
    case Turkish
    
    var title : String {
        switch self {
        case .Arabic: return "Arabic"
        case .Chinese: return "Chinese"
        case .Deutsch: return "Deutsch"
        case .English: return "English"
        case .French: return "French"
        case .Italian: return "Italian"
        case .Japanese: return "Japanese"
        case .Russian: return "Russian"
        case .Spanish: return "Spanish"
        case .Turkish: return "Turkish"
        case .Portugese: return "Portugese"
            
        }
    }
    var initial : String {
        switch self {
        case .Arabic: return "ar"
        case .Chinese: return "zh"
        case .Deutsch: return "de"
        case .English: return "en"
        case .French: return "fr"
        case .Italian: return "it"
        case .Japanese: return "ja"
        case .Russian: return "ru"
        case .Spanish: return "es"
        case .Turkish: return "tr"
        case .Portugese: return "pl"
        }
    }
    
}
