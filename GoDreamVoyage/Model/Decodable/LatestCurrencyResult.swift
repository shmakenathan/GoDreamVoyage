//
//  LatestCurrencyResult.swift
//  GoDreamVoyage
//
//  Created by Nathan on 03/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

struct LatestCurrencyResult: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
