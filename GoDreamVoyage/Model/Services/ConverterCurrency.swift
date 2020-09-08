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
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    func convert(sommeToChange: String, currencyBase: String, currencyReturn: String, rates: [String: Double]) -> String {
        var result = 0.0
        guard
            let double = Double(sommeToChange),
            let doubleRatesTarget = rates[currencyReturn],
            let doubleRatesBase = rates[currencyBase]
            else {
                return "erreur"
        }
        
        let newSommeCurrencyBase = double / doubleRatesBase
        result = newSommeCurrencyBase * doubleRatesTarget
        return getFormattedResultFrom(elementsForOperation: result)
    }
    
    
    private func getFormattedResultFrom(elementsForOperation: Double) -> String {
        let resultAsNSNumber = NSNumber(value: elementsForOperation)
        guard let formattedResultString = numberFormatter.string(from: resultAsNSNumber) else { return "error" }
        return formattedResultString
    }
}
