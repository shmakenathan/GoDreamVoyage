//
//  LanguageCurrencyTestCase.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 15/09/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import XCTest
@testable import GoDreamVoyage


class LanguageCurrencyTestCase: XCTestCase {
    
    func testLanguage() {
        var langue = Language.Arabic
        XCTAssertEqual(langue.initial, "ar")
        XCTAssertEqual(langue.title, "Arabic")
    }
    func testCurrency() {
        var currency = Currency.DollarAUS
        XCTAssertEqual(currency.initial, "AUD")
        XCTAssertEqual(currency.title, "Dollar Australien")
    }
    
}
