//
//  Weather.swift
//  GoDreamVoyage
//
//  Created by Nathan on 10/07/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

enum WeatherClimat: CaseIterable {
    case ClearSky
    case FewClouds
    case ScatteredClouds
    case BrokenClouds
    case ShowerRain
    case Rain
    case ThunderStorm
    case Snow
    case Mist
    
    var title : String {
        switch self {
        case .ClearSky: return "Dollar Americain"
        case .FewClouds: return "Dollar Australien"
        case .ScatteredClouds: return "Dollar Canadien"
        case .BrokenClouds: return "Euro"
        case .ShowerRain: return "Franc Suisse"
        case .Rain: return "Livre Sterling"
        case .ThunderStorm: return "Yen Japonais"
        case .Snow: return "Yuan"
        case .Mist: return ""
        }
    }
    
    
}

