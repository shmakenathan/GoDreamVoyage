//
//  WeatherNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation





class WeatherNetworkManager {
    
    
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        weatherUrlProvider: WeatherUrlProvider = WeatherUrlProvider()
    ) {
        self.networkManager = networkManager
        self.weatherUrlProvider = weatherUrlProvider
    }
    
    
    private let weatherUrlProvider: WeatherUrlProvider
    
    private let networkManager: NetworkManager
    
    func fetchWeather(cities: [String], completionHandler: @escaping (Result<[WeatherResponseResult], NetworkManagerError>) -> Void) {
        
        var cityResults: [WeatherResponseResult] = []
        
        for city in cities {
            guard let url = weatherUrlProvider.createUrl(city: city) else {
                completionHandler(.failure(.unknownErrorOccured))
                return
            }
            
            networkManager.fetchResult(url: url, completionHandler: { (singleResult: Result<WeatherResponseResult, NetworkManagerError>)  in
                
                switch singleResult {
                case .success(let singleWeatherResponse):
                    
                    cityResults.append(singleWeatherResponse)
                    if cityResults.count == cities.count {
                        completionHandler(.success(cityResults))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
                
            })
        }
    }
}
