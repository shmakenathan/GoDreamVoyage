//
//  CurrencyNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 03/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation




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
