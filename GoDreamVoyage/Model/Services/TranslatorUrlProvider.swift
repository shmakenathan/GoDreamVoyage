//
//  TranslatorUrlProvider.swift
//  GoDreamVoyage
//
//  Created by Nathan on 22/09/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

class TranslatorUrlProvider {
    func createUrl(baseLanguage: String, returnLanguage: String, textToTranslate: String) -> URL? {
        
        let key = "AIzaSyC4ScTYcgRiAY9NQ8TzTJkt1cFzvL6dg4k"
        let format = "text"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "source", value: baseLanguage),
            URLQueryItem(name: "target", value: returnLanguage),
            URLQueryItem(name: "q", value: textToTranslate),
            URLQueryItem(name: "format", value: format)
        ]
        return urlComponents.url
    }
}
