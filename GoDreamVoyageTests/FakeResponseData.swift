//
//  FakeResponseData.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 11/08/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data

    //Currency data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyResponseResult", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    //Translate data
    static var translateCorrectDate: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateResponseResult", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    //Weather data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherResponseResult", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class QuoteError: Error {}
    static let error = QuoteError()
}
