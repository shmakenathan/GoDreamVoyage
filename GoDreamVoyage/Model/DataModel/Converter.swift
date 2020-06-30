//
//  Converter.swift
//  GoDreamVoyage
//
//  Created by Nathan on 24/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
protocol ConverterDelegate: AnyObject {
}

class Converter {
    
    private weak var delegate: ConverterDelegate?
    
    init(delegate: ConverterDelegate? = nil) {
        self.delegate = delegate
    }
    
   
        
    func convert(sommeToChange: String, currencyBase: String, currencyReturn: String, rates: [String: Double]) -> Double {
        var result = 0.0
        if currencyBase != Currency.Euro.title {
            guard let double = Double(sommeToChange), let doubleRatesBase = rates[currencyBase], let doubleRatesTarget = rates[currencyReturn] else {
                return 0
            }
            let newSommeCurrencyBase = double / doubleRatesBase
            result = newSommeCurrencyBase * doubleRatesTarget
        }
        else {
            guard let double = Double(sommeToChange), let doubleRatesTarget = rates[currencyReturn] else {
                return 0
            }
            result = double * doubleRatesTarget
        }
        return result
    }
    
    
}
