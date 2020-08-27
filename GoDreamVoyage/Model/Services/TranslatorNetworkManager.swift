//
//  TranslatorNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

class TranslatorUrlProviederMock: TranslatorUrlProvider {
    override func createUrl(baseLanguage: String, returnLanguage: String, textToTranslate: String) -> URL? {
        return nil
    }
}


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


class TranslatorNetworkManager {
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        translatorUrlProvider: TranslatorUrlProvider = TranslatorUrlProvider()
    ) {
        self.networkManager = networkManager
        self.translatorUrlProvider = translatorUrlProvider
    }
    
    
    private let translatorUrlProvider: TranslatorUrlProvider
    
    private let networkManager: NetworkManager
    
    func fetchTranslation(baseLanguage: String, returnLanguage: String, textToTranslate: String, completionHandler: @escaping (Result<TranslateResponseResult, NetworkManagerError>) -> Void) {
        
        guard let url = translatorUrlProvider.createUrl(baseLanguage: baseLanguage, returnLanguage: returnLanguage, textToTranslate: textToTranslate) else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    }
}
