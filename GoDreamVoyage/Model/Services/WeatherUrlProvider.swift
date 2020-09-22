//
//  WeatherUrlProvider.swift
//  GoDreamVoyage
//
//  Created by Nathan on 22/09/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

class WeatherUrlProvider {
    func createUrl(city: String) -> URL? {
        
        let key = "0a3e463e85b227d34e2fc8815539ff20"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: key)
        ]
        return urlComponents.url
    }
}
