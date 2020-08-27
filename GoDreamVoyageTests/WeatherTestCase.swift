//
//  WeatherTestCase.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 26/08/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//
import XCTest
@testable import GoDreamVoyage

class WeatherTestCase: XCTestCase {

    func testGetWeatherShouldPostFailed() {
     
        let networkManager = NetworkManager(session:
            URLSessionFake(data: nil,
                           response: nil,
                           error: FakeResponseData.error))
        //When
        let weatherService = WeatherNetworkManager(networkManager: networkManager)
        
        weatherService.fetchWeather(cities: ["Paris"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGetWeatherShouldPostFailedIfNoData() {
        let networkManager = NetworkManager(session:
            URLSessionFake(data: nil,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let weatherService = WeatherNetworkManager(networkManager: networkManager)
        
        weatherService.fetchWeather(cities: ["Paris"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.noData)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGetWeatherShouldPostFailedIfInccorectResponse() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.weatherCorrectData,
                           response: FakeResponseData.responseKO,
                           error: nil))
        
        let weatherService = WeatherNetworkManager(networkManager: networkManager)
        
        weatherService.fetchWeather(cities: ["Paris"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.invalidResponseStatusCode)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGetWeatherShouldPostFailedIfIncorrectData() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.incorrectData,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let weatherService = WeatherNetworkManager(networkManager: networkManager)
        
        weatherService.fetchWeather(cities: ["Paris"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.couldNotDecodeJson)
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testGetWeatherShouldPostSuccesIfCorrectDataAndNoError() {
        
        let networkManager = NetworkManager(session:
            URLSessionFake(data: FakeResponseData.weatherCorrectData,
                           response: FakeResponseData.responseOK,
                           error: nil))
        
        let weatherService = WeatherNetworkManager(networkManager: networkManager)
        
        weatherService.fetchWeather(cities: ["Paris"]) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let weatherResponse):
                XCTAssertEqual(weatherResponse[0].name, "Paris")
                XCTAssertEqual(weatherResponse[0].main.temp , 20.64)
                XCTAssertEqual(weatherResponse[0].weather[0].weatherDescription, "clear sky")
            }
        }
    }
}
