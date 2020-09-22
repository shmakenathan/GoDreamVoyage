//
//  WeatherNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation



class CurrencyNetworkManager {
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        converterUrlProvider: ConverterUrlProvider = ConverterUrlProvider()
    ) {
        self.networkManager = networkManager
        self.converterUrlProvider = converterUrlProvider
    }
    
    private let converterUrlProvider: ConverterUrlProvider
    private let networkManager: NetworkManager
    
    
    func fetchCurrencyConverter(completionHandler: @escaping (Result<CurrencyResponseResult, NetworkManagerError>) -> Void) {
        
        guard let url = converterUrlProvider.createUrl() else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    }
}
