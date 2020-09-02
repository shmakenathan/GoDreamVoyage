//
//  Converter.swift
//  GoDreamVoyage
//
//  Created by Nathan on 24/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation


// ERUO => EURO => POUND
// DOLLAR 1
// 800 / 1 => EURO 800
// EURO => POUND



class ConverterCurrency {
    
    func convert(sommeToChange: String, currencyBase: String, currencyReturn: String, rates: [String: Double]) -> String {
        var result = 0.0
        
        guard
            let double = Double(sommeToChange),
            let doubleRatesTarget = rates[currencyReturn] else {
                
            return "erreur"
        }
        
        if currencyBase != Currency.Euro.initial {
            
            guard let doubleRatesBase = rates[currencyBase] else {
                return "erreur"
            }
            
            let newSommeCurrencyBase = double / doubleRatesBase
            result = newSommeCurrencyBase * doubleRatesTarget
        }
        else {
            
            result = double * doubleRatesTarget
        }
        return String(result)
    }
    
    
}
