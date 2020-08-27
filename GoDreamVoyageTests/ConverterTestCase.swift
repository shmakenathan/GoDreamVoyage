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
        //Given
        let converterService = NetworkManager(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        
        //Then
        
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        //Given
        
        //When
        
        //Then
        
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        
        //When
        
        //Then
        
    }
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        //Given
        
        //When
        
        //Then
        
    }
    
    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        //Given
        
        //When
        
        //Then
        
    }
}
