//
//  ConverterUrlProvider.swift
//  GoDreamVoyage
//
//  Created by Nathan on 22/09/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

class ConverterUrlProvider {
    func createUrl() -> URL? {
        let access_key = "aaa3bb4285d0f3ba1bcda2fc1926c039"
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: access_key)
        ]
        return urlComponents.url
    }
}

