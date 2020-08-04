//
//  Converter.swift
//  GoDreamVoyage
//
//  Created by Nathan on 24/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation


class ConverterCurrency {
    
    func convert(sommeToChange: String, currencyBase: String, currencyReturn: String, rates: [String: Double]) -> String {
        var result = 0.0
        if currencyBase != Currency.Euro.initial {
            guard let double = Double(sommeToChange), let doubleRatesBase = rates[currencyBase], let doubleRatesTarget = rates[currencyReturn] else {
                return "erreur"
            }
            let newSommeCurrencyBase = double / doubleRatesBase
            result = newSommeCurrencyBase * doubleRatesTarget
        }
        else {
            guard let double = Double(sommeToChange), let doubleRatesTarget = rates[currencyReturn] else {
                return "erreur"
            }
            result = double * doubleRatesTarget
        }
        return String(result)
    }
    
    
}
