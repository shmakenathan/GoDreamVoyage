//
//  WeatherNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation



class WeatherNetworkManager {
    
    
    private func createUrl(city: String) -> URL? {
        // TODO: Move function into its own service like "TranslatorNetworkManager"
        // TODO: Use URLComponent to create the url instead of appending string
        // TODO: Use add percent encoding for string to url
       let key = "0a3e463e85b227d34e2fc8815539ff20"
       
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather?"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: key)
            
        ]
        
        

        return urlComponents.url
    }
    
    private let networkManager = NetworkManager()
    
    
    
    func fetchWeather(cities: [String], completionHandler: @escaping (Result<[WeatherResponseResult], NetworkManagerError>) -> Void) {
        
        var cityResults: [WeatherResponseResult] = []
        
        for city in cities {
            guard let url = createUrl(city: city) else {
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
