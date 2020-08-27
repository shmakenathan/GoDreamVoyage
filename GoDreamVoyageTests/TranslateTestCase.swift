//
//  TranslateTestCase.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 26/08/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import XCTest

@testable import GoDreamVoyage

class TranslateTestCase: XCTestCase {
    
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        
        
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: nil,
                response: nil,
                error: FakeResponseData.error
            )
        )
        
        let translateService = TranslatorNetworkManager(networkManager: networkManager)
        
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: nil,
                response: FakeResponseData.responseKO,
                error: nil
            )
        )
        
        let translateService = TranslatorNetworkManager(networkManager: networkManager)
        
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.invalidResponseStatusCode)
            case .success:
                XCTFail()
            }
        }
        
        
        
    }
    
    
    
    func testGetTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: FakeResponseData.translateCorrectDate,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        
        let translateService = TranslatorNetworkManager(networkManager: networkManager)
        
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let translateResponseResult):
                let translatedText = translateResponseResult.data.translations.first!.translatedText
                XCTAssertEqual(translatedText, "language")
            }
        }
        
        
        
    }
    
    
    func testGetTranslateWithNoUrl() {
        
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: FakeResponseData.translateCorrectDate,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        let translatorUrlProvider = TranslatorUrlProviederMock()
        
        let translateService = TranslatorNetworkManager(
            networkManager: networkManager,
            translatorUrlProvider: translatorUrlProvider
        )
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
    }
    
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        //Given
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: nil,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        let translateService = TranslatorNetworkManager(networkManager: networkManager)
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.noData)
            case .success:
                XCTFail()
            }
        }
    }
    
    
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        
        let networkManager = NetworkManager(
            session: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil
            )
        )
        let translateService = TranslatorNetworkManager(networkManager: networkManager)
        translateService.fetchTranslation(baseLanguage: "fr", returnLanguage: "en", textToTranslate: "Bonjour") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.couldNotDecodeJson)
            case .success:
                XCTFail()
            }
        }
    }
    
}
