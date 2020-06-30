//
//  CurrencyNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 03/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation


//    class CurrencyUrlProvider {
//        func getLatestCurrencyUrl() -> URL {
//            let baseUrl = "http://data.fixer.io/api/latest"
//
//            let accessKeyParameter = "access_key"
//            let accessKeyValue = "aaa3bb4285d0f3ba1bcda2fc1926c039"
//
//
//            let urlComponent = URLComponents()
//            urlComponent.host = baseUrl
//            urlComponent.path =
//        }
//    }


class NetworkManager {
    
    //let currencyUrlProvider = CurrencyUrlProvider()
    
    
    
    func fetchResult<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void) {
        
        let session = URLSession.shared
    
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.unknownErrorOccured))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...399 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponseStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.couldNotDecodeJson))
                return
            }
            
            completionHandler(.success(result))
            
        }
        
        task.resume()
            
    }

}
