//
//  ConverterTestCase.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 26/08/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import XCTest
@testable import GoDreamVoyage
class ConverterTestCase: XCTestCase {
    
    func testGetCurrencyShouldPostFailedCallback() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: nil,
                           response: nil,
                           error: FakeResponseData.error))
        
        let converterService = CurrencyNetworkManager(networkManager: networkManager)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: nil,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let converterService = CurrencyNetworkManager(networkManager: networkManager)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.noData)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.currencyCorrectData,
                           response: FakeResponseData.responseKO,
                           error: nil))
        
        let converterService = CurrencyNetworkManager(networkManager: networkManager)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.invalidResponseStatusCode)
            case .success:
                XCTFail()
            }
        }
        
    }
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.incorrectData,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let converterService = CurrencyNetworkManager(networkManager: networkManager)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.couldNotDecodeJson)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.currencyCorrectData,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let converterService = CurrencyNetworkManager(networkManager: networkManager)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let currencyResponse):
                XCTAssertEqual(currencyResponse.rates["BGN"] , 1.956538)
                XCTAssertEqual(currencyResponse.rates["BIF"] , 2287.248099)
            }
        }
    }
    
    func testGetCurrencyWithNoUrl() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: nil,
                           response: nil,
                           error: nil))
        let converterUrlProvider = ConverterUrlProviderMock()
        let converterService = CurrencyNetworkManager(networkManager: networkManager, converterUrlProvider: converterUrlProvider)
        
        converterService.fetchCurrencyConverter() { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
    }
    func testConverterCurrency() {
        let convert = ConverterCurrency()
        
        let rates = [
            "USD": 1.160491,
            "GBP": 0.873479,
            "CAD": 1.531737,
            "CHF": 1.15744,
            "AUD": 1.559241,
            "JPY": 128.390942,
            "EUR": 1.0,
            "CNY": 7.471015
        ]
        XCTAssertEqual("7.47", convert.convert(sommeToChange: "1", currencyBase: "EUR", currencyReturn: "CNY", rates: rates))
        XCTAssertEqual("1", convert.convert(sommeToChange: "1", currencyBase: "USD", currencyReturn: "USD", rates: rates))
        XCTAssertEqual("erreur", convert.convert(sommeToChange: "jhdeh", currencyBase: "EUR", currencyReturn: "CNY", rates: rates))
    }
}
