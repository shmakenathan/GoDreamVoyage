//
//  TranslatorNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation





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
