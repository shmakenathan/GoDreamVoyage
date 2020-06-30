//
//  Currency.swift
//  GoDreamVoyage
//
//  Created by Nathan on 23/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

enum Currency: CaseIterable {
    case DollarUS
    case DollarAUS
    case DollarC
    case Euro
    case FrancS
    case LivreS
    case Yenj
    case Yuan
    
    var title : String {
        switch self {
        case .DollarUS: return "Dollar Americain"
        case .DollarAUS: return "Dollar Australien"
        case .DollarC: return "Dollar Canadien"
        case .Euro: return "Euro"
        case .FrancS: return "Franc Suisse"
        case .LivreS: return "Livre Sterling"
        case .Yenj: return "Yen Japonais"
        case .Yuan: return "Yuan"
        }
    }
    
    var initial : String {
        switch self {
        case .DollarUS: return "USD"
        case .DollarAUS: return "AUD"
        case .DollarC: return "CAD"
        case .Euro: return "EUR"
        case .FrancS: return "CHF"
        case .LivreS: return "GBP"
        case .Yenj: return "JPY"
        case .Yuan: return "CNY"
        }
    }
}

