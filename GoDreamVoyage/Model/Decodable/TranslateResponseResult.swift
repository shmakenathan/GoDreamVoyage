//
//  LatestTranslateResult.swift
//  GoDreamVoyage
//
//  Created by Nathan on 09/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct TranslateResponseResult: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
